require 'spec_helper'

describe 'editting todo items' do
    let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }
    let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }
    def visit_todo_list(list)
        visit "/todo_lists"
        within "#todo_list_#{list.id}" do
            click_link "Show items"
        end
    end

    def edit_todo_item(options={})
        options[:content]  ||= "Red beets"

        within("#todo_item_#{todo_item.id}") do
            click_link "Edit"
        end
        fill_in "Content", with: options[:content]
        click_button "Save"
    end

    it "is succesful with valid item" do
        visit_todo_list(todo_list)
        edit_todo_item

        expect(page).to have_content("Saved todo list item.")
        todo_item.reload
        expect(todo_item.content).to eq("Red beets")
    end
    
    it "it is unsuccesful with too short content" do
        visit_todo_list(todo_list)
        edit_todo_item content: "R"

        expect(page).to have_content("Error saving todo item.")
        expect(page).to have_content("Content is too short")
    end

end
