# frozen_string_literal: true

class UtilsController < ApplicationController
  def calculator
    @address = NetAM::Utils::IPCalculator.new(params[:ip], params[:subnet].to_i) rescue nil
  end

  def mac_vendor
    # Fill actions here
  end
end
