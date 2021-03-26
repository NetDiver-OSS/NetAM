# frozen_string_literal: true

class UtilsController < ApplicationController
  def calculator
    @address = NetAM::Utils::IPCalculator.new(params[:ip], params[:subnet].to_i) rescue nil
  end

  def mac_vendor
    @mac_vendors = MacAddress.where(mac: params[:mac].split(':').take(3).join(':').upcase) rescue nil
  end

  def ptr_resolution
    @ptr_resolutions = NetAM::Network::Dns.reverse_dns(params[:address]) rescue nil
  end
end
