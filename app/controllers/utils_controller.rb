# frozen_string_literal: true

class UtilsController < ApplicationController
  def calculator
    @address = NetAM::Utils::IPCalculator.new(params[:ip], params[:subnet].to_i) rescue nil
  end

  def mac_vendor
    mac_prefix_table = params[:mac].split(':')
    mac_prefix = "#{mac_prefix_table[0]}:#{mac_prefix_table[1]}:#{mac_prefix_table[2]}"
    @mac_vendor = MacAddress.where('mac = :mac', mac: mac_prefix)
  end
end
