require 'rails_helper'

RSpec.describe "Section", type: :request do
  before(:each) do
    admin = User.create!(email: "admin@netam.local", password: "azertyuiop123", admin: true)

    sign_in admin
  end

  let(:valid_attributes) do
    {
      name: 'section 1',
      network: '10.0.0.0/24',
      schedule: '24 hours'
    }
  end

  let(:invalid_attributes) do
    {
      name: 'section err',
      network: 'exemple.com',
      schedule: '24 hours'
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Section.create! valid_attributes
      get sections_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_section_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      pepite = Section.create! valid_attributes
      get edit_section_url(pepite)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Section" do
        expect do
          post sections_url, params: { section: valid_attributes }
        end.to change(Section, :count).by(1)
      end

      it "redirects to the created section" do
        post sections_url, params: { section: valid_attributes }
        expect(response).to redirect_to(section_url(Section.maximum(:id)))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Section" do
        expect do
          post sections_url, params: { section: invalid_attributes }
        end.to change(Section, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post sections_url, params: { section: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        skip("Add a hash of attributes valid for your model")
      end

      it "updates the requested section" do
        section = Section.create! valid_attributes
        patch section_url(section), params: { section: new_attributes }
        section.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the section" do
        section = Section.create! valid_attributes
        patch section_url(section), params: { section: new_attributes }
        section.reload
        expect(response).to redirect_to(section_url(section))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested section" do
      section = Section.create! valid_attributes
      expect do
        delete section_url(section)
      end.to change(Section, :count).by(-1)
    end

    it "redirects to the sections list" do
      section = Section.create! valid_attributes
      delete section_url(section)
      expect(response).to redirect_to(sections_url)
    end
  end
end
