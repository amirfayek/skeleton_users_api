class User < ApplicationRecord
  validates_presence_of :first_name, :last_name

  scope :filter_by_last_name, -> (last_name) { where(last_name: [*last_name]) }
  scope :filter_by_first_name, -> (first_name) { where(first_name: [*first_name]) }

  def self.filter(params)
    users = params[:user_ids].present? ? User.find(params[:user_ids]) : User.all
    users = users.filter_by_last_name(params[:last_name]) if params[:last_name].present?
    users = users.filter_by_first_name(params[:first_name]) if params[:first_name].present?
    users
  end
end
