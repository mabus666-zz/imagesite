require 'spec_helper'

describe "pages/new" do
  before(:each) do
    assign(:page, stub_model(Page,
      :title => "MyString",
      :content => "MyText",
      :excerpt => "MyText",
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pages_path, "post" do
      assert_select "input#page_title[name=?]", "page[title]"
      assert_select "textarea#page_content[name=?]", "page[content]"
      assert_select "textarea#page_excerpt[name=?]", "page[excerpt]"
      assert_select "input#page_status[name=?]", "page[status]"
    end
  end
end
