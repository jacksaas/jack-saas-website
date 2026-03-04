class Api::QuotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    # Honeypot check
    if params[:website_url].present?
      head :ok
      return
    end

    # Validate required fields
    if params[:name].blank? || params[:email].blank? || params[:description].blank?
      render json: { error: "Name, email, and description are required" }, status: :unprocessable_entity
      return
    end

    # Validate email format
    unless valid_email?(params[:email])
      render json: { error: "Please enter a valid email address" }, status: :unprocessable_entity
      return
    end

    # Rate limiting (simple in-memory, use Redis in production)
    client_ip = request.remote_ip
    key = "rate_limit:#{client_ip}"
    current_count = Rails.cache.read(key) || 0

    if current_count >= 5
      render json: { error: "Too many submissions. Please try again later." }, status: :too_many_requests
      return
    end

    # Increment rate limit counter
    Rails.cache.write(key, current_count + 1, expires_in: 1.hour)

    # Here you would typically send emails
    # For now, just return success
    render json: { message: "Quote request submitted successfully" }, status: :ok
  end

  private

  def valid_email?(email)
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    email_regex.match?(email.to_s.strip)
  end

  def quote_params
    params.permit(:name, :email, :company, :website, :description, :budget, :timeline, :website_url)
  end
end
