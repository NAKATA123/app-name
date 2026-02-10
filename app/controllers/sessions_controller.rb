class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to root_path
    else
      flash.now[:alert] = "メールアドレスかパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path
  end
end
