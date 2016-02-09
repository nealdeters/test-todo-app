require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
     it 'should make a task complete that is incomplete' do
       task = Task.create(complete: false)
       task.toggle_complete!
       expect(task.complete).to eq(true)
     end

     it 'should make a task incomplete that is complete' do
       task = Task.create(complete: true)
       task.toggle_complete!
       expect(task.complete).to eq(false)
     end
  end

  describe '#toggle_favorite!' do
    it 'should mark a task as a favorite' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end

    it 'should unmark a task as a favorite' do
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end
  end

  describe '#overdue?' do
    it 'should check if the task is overdue' do
      task = Task.create(deadline: Time.now - 1.hour)
      expect(task.overdue?).to eq(true)
    end

    it 'should check if the task is not overdue' do
      task = Task.create(deadline: Time.now + 1.hour)
      expect(task.overdue?).to eq(false)
    end
  end

  describe '#increment_priority!' do
    context 'when priority is not 10' do
      it 'should increase a tasks priority by 1' do
        task = Task.create(priority: 5)
        task.increment_priority!
        expect(task.priority).to eq(6)
      end 
    end

    context 'when priority is 10' do
      it 'should not increase a tasks priority by 1' do
        task = Task.create(priority: 10)
        task.increment_priority!
        expect(task.priority).to eq(10)
      end
    end
  end

  describe '#decrement_priority!' do
    context 'when priority is not 1' do
      it 'should decrease a tasks priority by 1' do
        task = Task.create(priority: 5)
        task.decrement_priority!
        expect(task.priority).to eq(4)
      end 
    end

    context 'when priority is 1' do
      it 'should not decrease a tasks priority by 1' do
        task = Task.create(priority: 1)
        task.decrement_priority!
        expect(task.priority).to eq(1)
      end
    end
  end

  describe '#snooze_hour!' do
    it 'should snooze the deadline for another hour' do
      time = Time.now
      task = Task.create(deadline: time)
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour)
    end
  end
end
