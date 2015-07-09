require "spec_helper.rb"

describe "Creating ToDo lists" do 
    it "redirects to todo list index page on succes" do
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New Todo List")
        
        fill_in "Title", with: "My Todo list"
        fill_in "Description", with: "This is what I'm doing today"
        click_button "Create Todo list"
        expect(page).to have_content("My Todo list")
    end
    it "gives an error when we fill in no name" do
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        click_link "New Todo list"
        fill_in "Description", with: "This is what I'm doing today"
        click_button "Create Todo list"
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what I'm doing today") 
    end
    it "gives an error when the title is less than 3 characters" do
        expect(TodoList.count).to eq(0)
        visit "/todo_lists"
        click_link "New Todo list"
        fill_in "Title", with: "My"
        fill_in "Description", with: "This is what I'm doing today"
        click_button "Create Todo list"
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what I'm doing today") 
    end
    it "gives an error when there is no description" do
        expect(TodoList.count).to eq(0)
        visit "/todo_lists"
        click_link "New Todo list"
        fill_in "Title", with: "Grocery list"
        fill_in "Description", with: ""
        click_button "Create Todo list"
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("Grocery list") 
    end


end
