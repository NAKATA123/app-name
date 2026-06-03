class ApplicationController < ActionController::Base
  include Sorcery::Controller

  helper_method :current_user, :logged_in?

  private

  def not_authenticated
    redirect_to login_path, alert: "ログインしてください"
  end

  def require_admin
    unless logged_in?
      redirect_to login_path, alert: "ログインしてください"
      return
    end
    unless current_user.admin?
      redirect_to root_path, alert: "管理者権限が必要です"
    end
  end
end
