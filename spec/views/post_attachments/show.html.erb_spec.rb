require 'spec_helper'

describe "post_attachments/show" do
  before(:each) do
    @post_attachment = assign(:post_attachment, stub_model(PostAttachment,
      :post_id => 1,
      :avatar => "Avatar"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Avatar/)
  end
end
