# frozen_string_literal: true

class UtilsController < ApplicationController
  def calculator
    @address = NetAM::Utils::IPCalculator.new(params[:ip], params[:subnet].to_i) rescue nil
  end

  def mac_vendor
    @mac_vendor = MacAddress.find_by(mac: params[:mac].split(':').take(3).join(':').upcase) rescue nil
  end
end
