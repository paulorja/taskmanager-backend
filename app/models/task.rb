class Task < ApplicationRecord
  belongs_to :priority
  belongs_to :member
  belongs_to :status
end
