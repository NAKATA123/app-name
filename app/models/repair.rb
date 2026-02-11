class Repair < ApplicationRecord
  belongs_to :car

  enum status: { reception: 0, working: 1, completed: 2 }
end
