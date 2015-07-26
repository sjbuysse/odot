require "spec_helper.rb"

describe "Deleting todo_item" do
    let!(:todo_list) {TodoList.create(title: "Grocery list", description: "Groceries")}
    let!(:todo_item) {todo_list.todo_items.create(content: "Milk")}

    def delete_todo_item
        within(dom_id_for(todo_item)) do
            click_link "Delete"
        end
    end
 
    it "succesfully deletes todo item" do
        visit_todo_list(todo_list)
        delete_todo_item

        expect(page).to have_content("Succesfully deleted todo item")
        expect(TodoItem.count).to eq(0)
    end
    
end
