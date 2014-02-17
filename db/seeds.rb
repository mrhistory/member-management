# Create test Member records
count = 0
20.times do
  Member.create(
    first_name: 'Test',
    last_name: count.to_s,
    address1: count.to_s + '23 Test Main St.',
    city: 'Anywhere',
    state: 'NY',
    zipcode: '1234' + count.to_s,
    email_address: 'test' + count.to_s + '@fake.com',
    phone_number: '123456789' + count.to_s
  )
  count += 1
end

# Create test User records
count = 0
20.times do
  User.create(
    email_address: 'test' + count.to_s + '@fake.com'
  )
  count += 1
end