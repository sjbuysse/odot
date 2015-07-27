class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates :content, presence:true, length: {minimum:2}

  scope :complete, -> {where("completed_at is not null")}
  scope :incomplete, -> {where("completed_at is null")}
 
  def completed?
    return !completed_at.blank?
  end
  
  def complete!
      self.update_attribute(:completed_at, Time.now)
  end
end
