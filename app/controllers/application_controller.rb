class ApplicationController < ActionController::Base
  rescue_from Timeout::Error, with: :handle_timeout

  def handle_timeout(exception)
    Mongoid.database.connection.close
  end
end
