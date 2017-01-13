require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe "GET #show" do
    it "assigns the requested contact to app contact" do
      contact = create :contact # Create the data needed
      get :show, id: contact.id # Fake the request
      # Validate something
      expect( assigns[:contact]).to eq(contact)
    end

    it "renders the show template" do
      contact = create :contact
      get :show, id: contact.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    context "without params[:letter]" do
      it "populates an array of all contacts" do
        smith = create :contact
        jones = create :contact
        get :index
        expect( assigns[:contacts]).to match_array([smith, jones])
      end

      it "render the index template" do
        get :index
        expect(response).to render_template(:index)
      end

    end
    context "with params letter" do
      it "populates an array of all relevant conacts" do
        johns = create :contact, last_name: "Johns"
        jones = create :contact, last_name: "Jones"
        smith = create :contact, last_name: "Smith"

        # Setup params letter for us
        get :index, letter: "J"

        expect(assigns[:contacts]).to eq(["Johns", "Jones"])
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new contact to @contact" do
      get :new
      expect(assigns[:contact]).to be_a_new(Contact)
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "get #edit" do
    it "assigns the correct contact to @contact" do
      c = create :contact
      get :edit, id: c.id
      expect(assigns[:contact]).to eq(c)
    end
    it "renders the edit template" do
      c = create :contact
      get :edit, id: c.id
      expect(response).to render_template(:edit)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the contact in the database" do
        # Fake a request passing valid attributes as params
        # Expect Contact.count to change by one
        expect {
          post :create, contact: FactoryGirl.attributes_for(:contact)
        }.to change(Contact, :count).by 1
      end
      it "redirects to the contact's show page" do
        post :create, contact: FactoryGirl.attributes_for(:contact)
        path = contact_path(assigns[:contact])
        expect(response).to redirect_to(path)
      end
    end

    context "with invalid attributes" do
      it "does not save the contact in the database" do
        expect {
          post :create, contact:
          FactoryGirl.attributes_for(:contact, last_name: nil)
        }.not_to change(Contact, :count)
      end
      it "renders the new template" do
        post :create, contact:
        FactoryGirl.attributes_for(:contact, last_name: nil)
        expect(response).to render_template(:new)
      end
    end
  end
  describe "PUT #update" do
    before :each do
      @contact = create :contact, first_name: "groucho", last_name: "marx"
    end
    context "with valid attributes" do
      it "locates the correct contact" do
        put :update, id: @contact.id, contact: FactoryGirl.attributes_for(:contact, first_name: "Harpo")
        expect(assigns[:contact]).to eq(@contact)
      end
      it "changes the contacts attributes" do
        put :update, id: @contact.id, contact: FactoryGirl.attributes_for(:contact, first_name: "Harpo")
        @contact.reload
        expect(@contact.first_name).to eq("Harpo")
      end
      it "redirects to the contact's show page" do
        put :update, id: @contact.id, contact: FactoryGirl.attributes_for(:contact, first_name: "Harpo")
        expect(response).to redirect_to(@contact)
      end
    end
    context "with invalid attributes" do
      it "does not update the contacts attributes" do
        put :update, id: @contact.id, contact: FactoryGirl.attributes_for(:contact, first_name: nil)
        @contact.reload
        expect(@contact.first_name).to eq("groucho")
      end
      it "re-renders the edit template" do
        put :update, id: @contact.id, contact: FactoryGirl.attributes_for(:contact, first_name: nil)
        expect(response).to render_template(:edit)
      end
    end
  end
  describe "DELETE #destroy" do
    before :each do
      @contact = create :contact
    end

    it "deletes the contact from the database" do
      expect {
        delete :destroy, id: @contact.id
      }.to change(Contact, :count).by (-1)
    end
    it "redirects to the contact#index page" do
      delete :destroy, id: @contact.id
      expect(response).to redirect_to(contacts_path)
    end
  end
 end
