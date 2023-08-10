class EmailsController < ApplicationController
  def index
    @emails = Email.all

    # Set start date, default to 7 days ago
    if params[:start_date].present?
      @start_date = Date.parse(params[:start_date])
    else
      @start_date = Date.today - 7.days
    end 

    # Set end date, default to today
    if params[:end_date].present?
      @end_date = Date.parse(params[:end_date])
    else
      @end_date = Date.today
    end

    emails = Email.where(date: @start_date..@end_date)

    # Query by sender
    if params[:sender].present?
      emails = emails.where("sender LIKE ?",  "%#{params[:sender]}%")
    end

    @emails = emails

    @email_count = {
      total: emails.count,
      start_date: @start_date,
      end_date: @end_date
    }
  end

  def show
    @email = Email.find(params[:id])
  end
end
