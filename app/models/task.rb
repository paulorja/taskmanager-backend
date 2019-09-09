class Task < ApplicationRecord

  belongs_to :priority
  belongs_to :status
  belongs_to :member

  validates :title, presence: true

  before_destroy do
    if self.status
      last_task = Task.last_position(self.status)
      move(last_task.position) if last_task
    end
  end

  before_create do
    last_task = Task.last_position(self.status)
    if last_task
      self.position = last_task.position + 1
    else
      self.position = 1
    end
  end

  before_update do
    if self.status_id_was != self.status_id and self.position_was == self.position
      oldStatus = Status.find(self.status_id_was)

      # send to last 
      last_task = Task.last_position(self.status)
      if last_task
        self.position = last_task.position + 1
      else
        self.position = 1
      end

      # update order tasks
      Task.where(status_id: status_id_was).where("position > ?", self.position_was).each do |t|
        t.update({position: t.position-1})
      end
    end
  end

  def transfer(position, status_id)
    to_status = Status.find_by_id(status_id)
    return false if to_status.nil? or to_status.id == status.id

    last_to_status_task = Task.last_position(to_status)
    return false if position > 1 and last_to_status_task.nil?

    # 1 - move to last current status position
    last_task = Task.last_position(self.status)
    move(last_task.position) if last_task
    # 2 - change status and send to last positin
    if last_to_status_task
      self.update({position: last_to_status_task.position + 1, status: to_status})
      # 3 - move to target_position
      move(position)
    else
      self.update({position: 1, status: to_status})
    end
    true
  end

  def move(position)
    last_task = Task.last_position(self.status)
    return false if position <= 0 or position > last_task.position or position == self.position
    # tasks up
    if position > self.position
      tasks = Task.where(status_id: status.id).where("position <= ?", position).where("position > ?", self.position)
      tasks.each do |task|
        task.update({position: task.position-1})
      end
      update({position: position})
    end
    # tasks bottom
    if position < self.position
      tasks = Task.where(status_id: status.id).where("position >= ?", position).where("position < ?", self.position)
      tasks.each do |task|
        task.update({position: task.position+1})
      end
      update({position: position})
    end
    return true
  end

  def self.last_position(status)
    where(status_id: status.id).order(position: :desc).first
  end

end
