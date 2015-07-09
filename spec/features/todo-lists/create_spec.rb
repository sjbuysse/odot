require "spec_helper.rb"

describe "Creating ToDo lists" do 
    def create_todo_list(options={})
        options[:title] ||=  "My Todo list"
        options[:description] ||= "This is my TodoList"
       
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New Todo List")
    
        fill_in "Title", with: options[:title] 
        fill_in "Description", with: options[:description]
        click_button "Create Todo list"
    end
    
    it "redirects to todo list index page on succes" do
        create_todo_list 
        
        expect(page).to have_content("My Todo list")
    end
    it "gives an error when we fill in no title" do
        expect(TodoList.count).to eq(0)

        create_todo_list title: ""
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what I'm doing today") 
    end
    it "gives an error when the title is less than 3 characters" do
        create_todo_list title: "My"
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("This is what I'm doing today") 
    end
    it "gives an error when there is no description" do
        create_todo_list description: ""
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0)

        visit "/todo_lists"
        expect(page).to_not have_content("Grocery list") 
    end


end
