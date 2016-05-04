class SectionsController < ApplicationController

  layout false

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:name => "default"})
  end

  def create
    #Instantiate a new object using form parameters
    @section = Section.new(section_params)
    #Save the section
    if @section.save
      flash[:notice] = "Section has been created successfully"
      # If the save succeeds, redirect to the index
      redirect_to(:action => 'index')
    else
      # If the save fails, redisplay the form so the user can fix mistakes
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "section updated successfully."
      redirect_to(:action => 'show')
    else 
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    section = Section.find(params[:id]).destroy
    flash[:notice] = "Section deleted successfully."
    redirect_to(:action => 'index')
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end
end
