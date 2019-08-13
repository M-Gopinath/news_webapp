class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  NEW_API = "eab87c9bbe3c4149a92ef97a4aa7b5c5"
  validates :first_name, :last_name, :presence =>true
end
