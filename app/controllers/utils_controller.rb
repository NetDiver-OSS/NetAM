# frozen_string_literal: true

class UtilsController < ApplicationController
  def calculator
    @address = NetAM::Utils::IPCalculator.new(params[:ip], params[:subnet].to_i) rescue nil
  end

  def mac_vendor
    @mac_vendors = MacAddress.where(mac: params[:mac].split(':').take(3).join(':').upcase) rescue nil
  end

  def network_splitter
    return if params[:network].nil? || params[:split_count].nil?

    network_range = IPAddress(params[:network].to_s)
    @networks = network_range / params[:split_count].to_i
  end

  def ptr_resolution
    @ptr_resolutions = NetAM::Network::Dns.reverse_dns(params[:address]) rescue nil
  end

  def dns_resolver
    return if params[:entry].nil? || params[:type].nil?

    @dns_resolutions = NetAM::Network::Dns.resolution(params[:entry], params[:type]) rescue nil
  end

  def whois
    @whois = Whois.lookup(params[:domain]) rescue nil
  end
end
