class SubjectsController < ApplicationController

  layout false

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Default"})
  end

  def create
    #Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    #Save the object
    if @subject.save
      flash[:notice] = "Subject created succesfully."
      #If the save succeeds, reditect to the index action
      redirect_to(:action => 'index')
    else
      #If the save fails, redisplay the form so the user can fix problems
      render('new')
    end
  end

  def edit

    @subject = Subject.find(params[:id])

  end

  def update
    # Find an existing object using form parameters
    @subject = Subject.find(params[:id])
    #Update the object
    if @subject.update_attributes(subject_params) 
    flash[:notice] = "Subject updated succesfully."
      #If the update succeeds, reditect to the index action
      redirect_to(:action => 'show', :id => @subject.id)
    else
      #If the update fails, redisplay the form so the user can fix problems
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' deleted succesfully."
    redirect_to(:action => 'index')

  end

  private

  def subject_params
    # same as using "params[:subject]", except that it:
    # - taises an error if :subject is not present
    # - allows listed attributes to be mass-assigned
    params.require(:subject).permit(:name, :position, :visible)
  end

end
