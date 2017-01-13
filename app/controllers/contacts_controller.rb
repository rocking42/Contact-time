class ContactsController < ApplicationController
  def index
    if params[:letter]
      @contacts = Contact.by_letter(params[:letter])
    else
      @contacts = Contact.all
    end
  end

  def show
    # stored as assigns[:contact] in specs
    @contact = Contact.find_by id: params[:id]
  end

  def new
    @contact = Contact.new
  end

  def edit
    @contact = Contact.find_by id: params[:id]
  end

  def create
    @contact = Contact.new contact_params
    if @contact.save
      redirect_to contact_path(@contact)
    else
      render :new
    end
  end

  def update
    @contact = Contact.find_by id: params[:id]
    if @contact.update contact_params
      redirect_to contact_path(@contact)
    else
      render :edit
    end
  end

  def destroy
    contact = Contact.find_by id: params[:id]
    contact.destroy

    redirect_to contacts_path #the index page
  end

  private
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email)
    end

end
