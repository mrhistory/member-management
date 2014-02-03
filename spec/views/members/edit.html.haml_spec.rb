require 'spec_helper'

describe "members/edit" do
  before(:each) do
    @member = assign(:member, stub_model(Member,
      :email_address => "MyString",
      :first_name => "MyString",
      :last_name => "MyString",
      :address1 => "MyString",
      :address2 => "MyString",
      :city => "MyString",
      :state => "GA",
      :zipcode => "MyString",
      :phone_number => "MyString"
    ))
  end

  it "renders the edit member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", member_path(@member), "post" do
      assert_select "input#member_email_address[name=?]", "member[email_address]"
      assert_select "input#member_first_name[name=?]", "member[first_name]"
      assert_select "input#member_last_name[name=?]", "member[last_name]"
      assert_select "input#member_address1[name=?]", "member[address1]"
      assert_select "input#member_address2[name=?]", "member[address2]"
      assert_select "input#member_city[name=?]", "member[city]"
      assert_select "select#member_state[name=?]", "member[state]"
      assert_select "input#member_zipcode[name=?]", "member[zipcode]"
      assert_select "input#member_phone_number[name=?]", "member[phone_number]"
    end
  end
end
