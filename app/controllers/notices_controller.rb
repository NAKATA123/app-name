class NoticesController < ApplicationController
  before_action :require_login

  def create
    notice = Notice.find_or_initialize_by(notice_date: notice_date)

    if notice_params[:content].blank?
      notice.destroy if notice.persisted?
      render json: { content: "" }
    elsif notice.update(notice_params)
      render json: { id: notice.id, content: notice.content }
    else
      render json: { errors: notice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    notice = Notice.find(params[:id])

    if notice_params[:content].blank?
      notice.destroy
      render json: { content: "" }
    elsif notice.update(notice_params)
      render json: { id: notice.id, content: notice.content }
    else
      render json: { errors: notice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def notice_date
    params[:notice_date].presence || Time.zone.today
  end

  def notice_params
    params.require(:notice).permit(:content)
  end
end
