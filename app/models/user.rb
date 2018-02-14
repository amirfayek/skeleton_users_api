class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true

  before_create :generate_authentication_token!

  scope :filter_by_last_name, -> (last_name) { where(last_name: [*last_name]) }
  scope :filter_by_first_name, -> (first_name) { where(first_name: [*first_name]) }

  def self.filter(params)
    users = params[:user_ids].present? ? User.find(params[:user_ids]) : User.all
    users = users.filter_by_last_name(params[:last_name]) if params[:last_name].present?
    users = users.filter_by_first_name(params[:first_name]) if params[:first_name].present?
    users
  end

  def generate_authentication_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end
end
