# encoding: utf-8
class HomeController < ApplicationController

  layout 'home'

  def index
    redirect_to companies_url if mobile_device?
  end

  private
  def mobile_device?
    request.user_agent =~ /Mobile|webOS/
  end
end
