Fabricator(:advert) do	
  name 'test_advert_name'
  description { Faker::Lorem.sentence(10) }
  category { Fabricate(:category) }
  user { Fabricate(:user) }
  kind 'sale'
  price 10000
  state [:published, :awaiting_publication, :declined, :new, :archived].sample
end
