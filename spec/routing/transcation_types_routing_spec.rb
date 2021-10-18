require "rails_helper"

RSpec.describe TranscationTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/transcation_types").to route_to("transcation_types#index")
    end

    it "routes to #new" do
      expect(get: "/transcation_types/new").to route_to("transcation_types#new")
    end

    it "routes to #show" do
      expect(get: "/transcation_types/1").to route_to("transcation_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/transcation_types/1/edit").to route_to("transcation_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/transcation_types").to route_to("transcation_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/transcation_types/1").to route_to("transcation_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/transcation_types/1").to route_to("transcation_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/transcation_types/1").to route_to("transcation_types#destroy", id: "1")
    end
  end
end
