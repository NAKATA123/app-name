class Repair < ApplicationRecord
  belongs_to :car
  has_many :rentals, dependent: :destroy

  enum status: { reception: 0, working: 1, completed: 2 }

  def status_jp
    {
      "reception" => "受付中",
      "working" => "作業中",
      "completed" => "完了"
    }[status]
  end
end
