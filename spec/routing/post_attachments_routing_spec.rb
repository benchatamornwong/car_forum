require "spec_helper"

describe PostAttachmentsController do
  describe "routing" do

    it "routes to #index" do
      get("/post_attachments").should route_to("post_attachments#index")
    end

    it "routes to #new" do
      get("/post_attachments/new").should route_to("post_attachments#new")
    end

    it "routes to #show" do
      get("/post_attachments/1").should route_to("post_attachments#show", :id => "1")
    end

    it "routes to #edit" do
      get("/post_attachments/1/edit").should route_to("post_attachments#edit", :id => "1")
    end

    it "routes to #create" do
      post("/post_attachments").should route_to("post_attachments#create")
    end

    it "routes to #update" do
      put("/post_attachments/1").should route_to("post_attachments#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/post_attachments/1").should route_to("post_attachments#destroy", :id => "1")
    end

  end
end
