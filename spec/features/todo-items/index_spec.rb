require 'spec_helper'

describe "Viewing todo items" do
    let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }
    def visit_todo_list(list)
        visit "/todo_lists"
        within "#todo_list_#{list.id}" do
            click_link "Show items"
        end
    end

    it "displays the TodoList title" do
        visit_todo_list(todo_list)
        expect(page).to have_content(todo_list.title)
    end

    it "displays no todo items when the list is empty" do
        visit_todo_list(todo_list)
        expect(page.all("ul.todo_items li").size).to eq(0)
    end   
    
    it "displays todo items when the list is not empty" do
        l = TodoItem.create(content: "paksoi")        
        d = TodoItem.create(content: "gin")        
        todo_list.todo_items << l
        todo_list.todo_items << d
        visit_todo_list(todo_list)
        expect(page.all("ul.todo_items li").size).to eq(2)
        expect(page).to have_content("paksoi")
    end   

end
