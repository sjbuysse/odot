require 'spec_helper'

describe TodoList do
    it{ should have_many(:todo_items) }

    describe "#has_completed_items?" do
        let!(:todo_list) {TodoList.create(title: "Groceries", description:"Grocery list")}

        context "the list has completed items" do
            it "returns true" do
                todo_item = todo_list.todo_items.create(content: "Milk", completed_at: 1.day.ago)
                expect(todo_list.has_completed_items?).to be_true
            end
        end
        context "the list has no completed items" do
            it "returns false" do
                todo_item = todo_list.todo_items.create(content: "Milk")
                expect(todo_list.has_completed_items?).to be_false
            end
        end
    end
    
    describe "#has_incompleted_items?" do
        let!(:todo_list) {TodoList.create(title: "Groceries", description:"Grocery list")}

        context "the list has no incompleted items" do
            it "returns false" do
                todo_item = todo_list.todo_items.create(content: "Milk", completed_at: 1.day.ago)
                expect(todo_list.has_incompleted_items?).to be_false
            end
        end
        context "the list has incompleted items" do
            it "returns true" do
                todo_item = todo_list.todo_items.create(content: "Milk")
                expect(todo_list.has_incompleted_items?).to be_true
            end
        end
    end

end
