class TodoList < ActiveRecord::Base
    validates :title, presence: true, length: {minimum: 3}
    validates :description, presence: true, length: {minimum: 5}
    has_many :todo_items

    def has_completed_items?
        return todo_items.complete.count > 0
    end
    
    def has_incompleted_items?
        return todo_items.incomplete.count > 0
    end
end
