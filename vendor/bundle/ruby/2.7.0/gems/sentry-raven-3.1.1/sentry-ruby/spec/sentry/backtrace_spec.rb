require 'spec_helper'

RSpec.describe Sentry::Backtrace do
  let(:configuration) { Sentry::Configuration.new }

  before(:each) do
    @backtrace = Sentry::Backtrace.parse(Thread.current.backtrace, configuration: configuration)
  end

  it "calls backtrace_cleanup_callback if it's present in the configuration" do
    called = false
    callback = proc do |backtrace|
      called = true
      backtrace
    end
    configuration.backtrace_cleanup_callback = callback
    Sentry::Backtrace.parse(Thread.current.backtrace, configuration: configuration)

    expect(called).to eq(true)
  end

  it "#lines" do
    expect(@backtrace.lines.first).to be_a(Sentry::Backtrace::Line)
  end

  it "#inspect" do
    expect(@backtrace.inspect).to match(/Backtrace: .*>$/)
  end

  it "#to_s" do
    expect(@backtrace.to_s).to match(/backtrace_spec.rb:\d/)
  end

  it "==" do
    @backtrace2 = Sentry::Backtrace.new(@backtrace.lines)
    expect(@backtrace).to be == @backtrace2
  end
end
