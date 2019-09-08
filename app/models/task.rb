class Task < ApplicationRecord

  belongs_to :priority
  belongs_to :status
  belongs_to :member

  validates :title, presence: true

  def self.last_position(status)
    where(status_id: status.id).order(position: :desc).first
  end

  def move(position)
    last_task = Task.last_position(self.status)
    return false if position <= 0 or position > last_task.position or position == self.position
    # tasks up
    if position > self.position
      tasks = Task.where(status_id: status.id).where("position <= ?", position).where("position > ?", self.position)
      tasks.each do |task|
        task.update_attribute(:position, task.position-1)
      end
      update_attribute(:position, position)
    end
    # tasks bottom
    if position < self.position
      tasks = Task.where(status_id: status.id).where("position >= ?", position).where("position < ?", self.position)
      tasks.each do |task|
        task.update_attribute(:position, task.position+1)
      end
      update_attribute(:position, position)
    end
    return true
  end

  before_create do
    last_task = Task.last_position(self.status)
    if last_task
      self.position = last_task.position + 1
    else
      self.position = 1
    end
  end

end
