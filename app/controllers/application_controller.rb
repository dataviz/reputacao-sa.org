class ApplicationController < ActionController::Base
  protect_from_forgery

  def unslugfy(name)
    if name.include?('_')
      name = name.split('_').first
    end
    name.downcase.strip.gsub('_', ' ').gsub('-', '')
  end

end
