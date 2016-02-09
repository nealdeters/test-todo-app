require 'rails_helper'

RSpec.describe List, type: :model do
  
  describe '#complete_all_tasks!' do
    it 'should complete all tasks within the list' do
      list = List.create(name: "groceries")
      
      ['milk', 'cereal'].each do |task_name|
        Task.create(name: task_name, complete: false, list_id: list.id)
      end

      list.complete_all_tasks!
      
      list.tasks.each do |task|
        expect(task.complete).to eq(true)
      end

    end
  end

  describe '#snooze_all_tasks!' do
    it 'should snooze all tasks for 1 hour' do
      list = List.create(name: "groceries")
      
      time = Time.new(2015, 1, 1)
      time2 = time + 1.hour

      ['milk', 'cereal'].each do |task_name|
        Task.create(name: task_name, deadline: time, list_id: list.id)
      end

      list.snooze_all_tasks!
      
      list.tasks.each do |task|
        expect(task.deadline).to eq(time2)
      end

    end
  end

  describe '#total_duration' do
    it 'should find the total duration of all tasks in the list' do
      list = List.create(name: "groceries")
      
      ['milk', 'cereal'].each do |task_name|
        Task.create(name: task_name, duration: 30, list_id: list.id)
      end

      expect(list.total_duration).to eq(60)
    end
  end

  describe '#incomplete_tasks' do
    it 'should return all the tasks that are incomplete' do
      list = List.create(name: "groceries")
      
      Task.create(name: "milk", complete: false, list_id: list.id)
      Task.create(name: "cereal", complete: true, list_id: list.id)

      result = list.tasks.where(complete: false)

      expect(list.incomplete_tasks).to eq(result)
    end
  end

  describe '#favorite_tasks' do
    it 'should return all the favorited tasks' do
      list = List.create(name: "groceries")
      
      Task.create(name: "milk", favorite: false, list_id: list.id)
      Task.create(name: "cereal", favorite: true, list_id: list.id)

      result = list.tasks.where(favorite: true)

      expect(list.favorite_tasks).to eq(result)
    end
  end

end
