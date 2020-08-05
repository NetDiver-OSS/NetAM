class UtilsController < ApplicationController
  def calculator
    @address = NetAM::Utils::IPCalculator.new(params[:ip]) rescue nil
  end
end
