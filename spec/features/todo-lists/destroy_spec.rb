require "spec_helper"

describe "Deleting to do lists" do 
        let!(:todo_list) {TodoList.create(title: "Groceries", description: "Grocery list.")}
        
        it "is successfull when clicking delete button" do
            visit "/todo_lists"
            expect(page).to have_content("Groceries")
            within(dom_id_for(todo_list)) do
                click_link "Destroy"
            end

            expect(page).to_not have_content(todo_list.title)
            expect(TodoList.count).to eq(0)
        end
end 
