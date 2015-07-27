require 'spec_helper'

describe TodoItem do
     it { should belong_to(:todo_list) }

     describe "#completed?" do 
         let!(:todo_item) {TodoItem.create(content: "Milk")}

         context "When completed_at is blank" do 
             it "returns false" do
                todo_item.completed_at = nil
                expect(todo_item.completed?).to be_false
             end
         end
         context "When completed_at is not blank" do 
             it "returns true" do
                todo_item.completed_at = Time.now
                expect(todo_item.completed?).to be_true
             end
         end
     end
end
