require 'spec_helper'

describe "texts/show" do
  before(:each) do
    @text = assign(:text, stub_model(Text,
      :content => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
