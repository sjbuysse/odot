class TodoItemsController < ApplicationController

  before_action :find_todo_list

  def index
  end
  
  def new
      @todo_item = @todo_list.todo_items.new
  end
  
  def create
     @todo_item = @todo_list.todo_items.new(todo_item_params)

     if @todo_item.save
         flash[:success] = "Added todo list item."
         redirect_to(todo_list_todo_items_path(@todo_list))
     else
         flash[:error] = "There was a problem adding that todo item to the list"
         render action: :new
     end
  end
    
  def edit
     @todo_item = @todo_list.todo_items.find(params[:id])
  end
  
  def update
     @todo_item = @todo_list.todo_items.find(params[:id])
        
     if @todo_item.update(todo_item_params)
         flash[:success]="Saved todo list item."
         redirect_to(todo_list_todo_items_path(@todo_list))
     else
        flash[:error]="Error saving todo item."
        render action: :edit
     end
     
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])
    if @todo_item.destroy
        flash[:success] = "Succesfully deleted todo item"
    else
        flash[:error]="Could not delete todo item"
    end
        redirect_to(todo_list_todo_items_path(@todo_list))
  end

  private
  def todo_item_params
    params[:todo_item].permit(:content)
  end

  def find_todo_list
     @todo_list = TodoList.find(params[:todo_list_id])
  end
end
