# frozen_string_literal: true

require 'grape/router/route'
require 'grape/util/cache'

module Grape
  class Router
    attr_reader :map, :compiled

    def self.normalize_path(path)
      path = +"/#{path}"
      path.squeeze!('/')
      path.sub!(%r{/+\Z}, '')
      path = '/' if path == ''
      path
    end

    def self.supported_methods
      @supported_methods ||= Grape::Http::Headers::SUPPORTED_METHODS + ['*']
    end

    def initialize
      @neutral_map = []
      @neutral_regexes = []
      @map = Hash.new { |hash, key| hash[key] = [] }
      @optimized_map = Hash.new { |hash, key| hash[key] = // }
    end

    def compile!
      return if compiled
      @union = Regexp.union(@neutral_regexes)
      @neutral_regexes = nil
      self.class.supported_methods.each do |method|
        routes = map[method]
        @optimized_map[method] = routes.map.with_index do |route, index|
          route.index = index
          Regexp.new("(?<_#{index}>#{route.pattern.to_regexp})")
        end
        @optimized_map[method] = Regexp.union(@optimized_map[method])
      end
      @compiled = true
    end

    def append(route)
      map[route.request_method] << route
    end

    def associate_routes(pattern, **options)
      @neutral_regexes << Regexp.new("(?<_#{@neutral_map.length}>)#{pattern.to_regexp}")
      @neutral_map << Grape::Router::AttributeTranslator.new(**options, pattern: pattern, index: @neutral_map.length)
    end

    def call(env)
      with_optimization do
        response, route = identity(env)
        response || rotation(env, route)
      end
    end

    def recognize_path(input)
      any = with_optimization { greedy_match?(input) }
      return if any == default_response
      any.endpoint
    end

    private

    def identity(env)
      route = nil
      response = transaction(env) do |input, method|
        route = match?(input, method)
        process_route(route, env) if route
      end
      [response, route]
    end

    def rotation(env, exact_route = nil)
      response = nil
      input, method = *extract_input_and_method(env)
      map[method].each do |route|
        next if exact_route == route
        next unless route.match?(input)
        response = process_route(route, env)
        break unless cascade?(response)
      end
      response
    end

    def transaction(env)
      input, method = *extract_input_and_method(env)
      response = yield(input, method)

      return response if response && !(cascade = cascade?(response))
      last_neighbor_route = greedy_match?(input)

      # If last_neighbor_route exists and request method is OPTIONS,
      # return response by using #call_with_allow_headers.
      return call_with_allow_headers(env, last_neighbor_route) if last_neighbor_route && method == Grape::Http::Headers::OPTIONS && !cascade

      route = match?(input, '*')

      return last_neighbor_route.endpoint.call(env) if last_neighbor_route && cascade && route

      if route
        response = process_route(route, env)
        return response if response && !(cascade = cascade?(response))
      end

      return call_with_allow_headers(env, last_neighbor_route) if !cascade && last_neighbor_route

      nil
    end

    def process_route(route, env)
      prepare_env_from_route(env, route)
      route.exec(env)
    end

    def make_routing_args(default_args, route, input)
      args = default_args || { route_info: route }
      args.merge(route.params(input) || {})
    end

    def extract_input_and_method(env)
      input = string_for(env[Grape::Http::Headers::PATH_INFO])
      method = env[Grape::Http::Headers::REQUEST_METHOD]
      [input, method]
    end

    def with_optimization
      compile! unless compiled
      yield || default_response
    end

    def default_response
      [404, { Grape::Http::Headers::X_CASCADE => 'pass' }, ['404 Not Found']]
    end

    def match?(input, method)
      current_regexp = @optimized_map[method]
      return unless current_regexp.match(input)
      last_match = Regexp.last_match
      @map[method].detect { |route| last_match["_#{route.index}"] }
    end

    def greedy_match?(input)
      return unless @union.match(input)
      last_match = Regexp.last_match
      @neutral_map.detect { |route| last_match["_#{route.index}"] }
    end

    def call_with_allow_headers(env, route)
      prepare_env_from_route(env, route)
      env[Grape::Env::GRAPE_ALLOWED_METHODS] = route.allow_header.join(', ').freeze
      route.endpoint.call(env)
    end

    def prepare_env_from_route(env, route)
      input, = *extract_input_and_method(env)
      env[Grape::Env::GRAPE_ROUTING_ARGS] = make_routing_args(env[Grape::Env::GRAPE_ROUTING_ARGS], route, input)
    end

    def cascade?(response)
      response && response[1][Grape::Http::Headers::X_CASCADE] == 'pass'
    end

    def string_for(input)
      self.class.normalize_path(input)
    end
  end
end
