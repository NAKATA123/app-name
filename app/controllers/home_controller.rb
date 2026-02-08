class HomeController < ApplicationController
  def top
    redirect_to login_path unless logged_in?
  end
end
