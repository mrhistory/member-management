json.array!(@members) do |member|
  json.extract! member, :id, :email_address, :first_name, :last_name, :address1, :address2, :city, :state, :zipcode, :phone_number
  json.url member_url(member, format: :json)
end
