class Customer < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_many :repairs, through: :cars

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "notes", "phone", "updated_at"]
  end
end