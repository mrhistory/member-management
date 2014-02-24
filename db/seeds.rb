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

Member.create(
  first_name: 'Jamison',
  last_name: 'Chambers',
  address1: '323 Villa Ridge Pkwy',
  city: 'Lawrenceville',
  state: 'GA',
  zipcode: '30044',
  email_address: 'mrhistory@gmail.com',
  phone_number: '7706565518'
)

Member.create(
  first_name: 'Jim',
  last_name: 'Chambers',
  address1: '318 Villa Ridge Pkwy',
  city: 'Lawrenceville',
  state: 'GA',
  zipcode: '30044',
  email_address: 'mrhistory@gmail.com',
  phone_number: '7706565518'
)

# Create test User records
count = 0
20.times do
  User.create(
    email_address: 'test' + count.to_s + '@fake.com',
    password: 'fake',
    password_confirmation: 'fake'
  )
  count += 1
end

User.create(
  email_address: 'mrhistory@gmail.com',
  password: 'admin01',
  password_confirmation: 'admin01'
)