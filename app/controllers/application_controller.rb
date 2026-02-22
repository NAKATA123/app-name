class ApplicationController < ActionController::Base
  include Sorcery::Controller

  helper_method :current_user, :logged_in?
end
