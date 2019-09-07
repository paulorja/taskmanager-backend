class Task < ApplicationRecord

  belongs_to :priority
  belongs_to :status
  belongs_to :member

  validates :title, presence: true

end
