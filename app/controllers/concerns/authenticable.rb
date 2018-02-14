module Authenticable

  # Devise methods overwrites
  def current_user
    bearer_token
    @current_user ||= User.find_by(auth_token: bearer_token)
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
                status: :unauthorized unless current_user.present?
  end

  def user_signed_in?
    current_user.present?
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers["Authorization"]
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end