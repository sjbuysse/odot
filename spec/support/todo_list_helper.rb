module TodoListHelper
    def visit_todo_list(list)
        visit "/todo_lists"
        within "#todo_list_#{list.id}" do
            click_link "Show items"
        end
    end
end
