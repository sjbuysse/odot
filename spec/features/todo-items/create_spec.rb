require "spec_helper.rb"

describe "Adding todo items" do
    let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }
    def visit_todo_list(list)
        visit "/todo_lists"
        within "#todo_list_#{list.id}" do
            click_link "Show items"
        end
    end
    
    it "is successful with valid content" do
        visit_todo_list(todo_list)
        click_link "New todo item"
        fill_in "Content", with: "Milk"
        click_button "Save"

        expect(page).to have_content("Added todo list item.")
        expect(page).to have_content("Milk")
    end
end
