class List < ActiveRecord::Base
  has_many :tasks

  def complete_all_tasks!
    tasks.update_all(complete: true)
  end

  def snooze_all_tasks!
    tasks.each { |task| task.snooze_hour! }
    # tasks.each do |task|
    #   task.snooze_hour!
    # end
  end

  def total_duration
    tasks.sum(:duration)
    # total = 0
    # tasks.each do |task|
    #   total += task.duration
    # end
    # total
  end

  def incomplete_tasks
    tasks.where(complete: false)
    # array_of_tasks = []
    # tasks.each do |task|
    #   if !task.complete
    #     array_of_tasks << task
    #   end
    # end
    # array_of_tasks
  end

  def favorite_tasks
    tasks.where(favorite: true)
    # array_of_tasks = []
    # tasks.each do |task|
    #   if task.favorite
    #     array_of_tasks << task
    #   end
    # end
    # array_of_tasks
  end
end
