require "spec_helper.rb"

describe "Adding todo items" do
    let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }
    def visit_todo_list(list)
        visit "/todo_lists"
        within "#todo_list_#{list.id}" do
            click_link "Show items"
        end
    end

    def create_todo_item(options={})
        options[:content]  ||= "Milk"

        click_link "New todo item"
        fill_in "Content", with: options[:content]
        click_button "Save"
    end
    
    it "is successful with valid content" do
        visit_todo_list(todo_list)
        create_todo_item

        expect(page).to have_content("Added todo list item.")
        expect(page).to have_content("Milk")
    end
    it "displays an error when nothing is filled in" do
        visit_todo_list(todo_list)
        create_todo_item content: ""

        expect(page).to have_content("There was a problem adding that todo item to the list")
        expect(page).to have_content("Content can't be blank")
    end
    
    it "displays an error when item is less than 2 characters" do
        visit_todo_list(todo_list)
        create_todo_item content: "s"

        expect(page).to have_content("There was a problem adding that todo item to the list")
        expect(page).to have_content("Content is too short")
    end


end
