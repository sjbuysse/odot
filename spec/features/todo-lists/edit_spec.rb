require "spec_helper"

describe "Editing to do lists" do 
    def update_todo_list(options={})
        options[:title] ||= "New title"
        options[:description] ||= "New description"
        
        todo_list = options[:todo_list]
        
        visit "/todo_lists" 
        within "#todo_list_#{todo_list.id}" do 
            click_link "Edit"
        end
       
        fill_in "Title", with: options[:title]
        fill_in "Description", with: options[:description]
        click_button "Update Todo list"

        todo_list.reload
    end

    it "updates todo list correctly with correct information" do
        todo_list = TodoList.create(title: "Groceries", description: "Grocery list.")
        update_todo_list todo_list: todo_list

        expect(page).to have_content("Todo list was successfully updated.")
        expect(todo_list.title).to eq("New title")
        expect(todo_list.description).to eq("New description")
    end
end
    
