class PasswordsController < ApplicationController
  before_action :require_login

  def edit
  end

  def update
    if current_user.valid_password?(params[:current_password])
      if params[:password] == params[:password_confirmation]
        current_user.update(
          password: params[:password],
          password_confirmation: params[:password_confirmation]
        )
        redirect_to root_path, notice: "パスワードを変更しました"
      else
        flash.now[:alert] = "新しいパスワードが一致しません"
        render :edit, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "現在のパスワードが正しくありません"
      render :edit, status: :unprocessable_entity
    end
  end
end
