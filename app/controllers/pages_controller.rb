class PagesController < ApplicationController

  layout false
  
  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new({:name => "default"})
  end

  def create
    #Instantiate a new object using form parameters
    @page = Page.new(page_params)
    #Save the Page
    if @page.save
      flash[:notice] = "Page has been created successfully"
      # If the save succeeds, redirect to the index
      redirect_to(:action => 'index')
    else
      # If the save fails, redisplay the form so the user can fix mistakes
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page updated successfully."
      redirect_to(:action => 'show')
    else 
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page deleted successfully."
    redirect_to(:action => 'index')
  end

  private

  def page_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:subject).permit(:subject_id, :name, :permalink, :position, :visible)
  end


end
