class User < ApplicationRecord
  authenticates_with_sorcery!

  enum role: { employee: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
end
