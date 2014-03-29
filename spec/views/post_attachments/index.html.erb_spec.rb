require 'spec_helper'

describe "post_attachments/index" do
  before(:each) do
    assign(:post_attachments, [
      stub_model(PostAttachment,
        :post_id => 1,
        :avatar => "Avatar"
      ),
      stub_model(PostAttachment,
        :post_id => 1,
        :avatar => "Avatar"
      )
    ])
  end

  it "renders a list of post_attachments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Avatar".to_s, :count => 2
  end
end
