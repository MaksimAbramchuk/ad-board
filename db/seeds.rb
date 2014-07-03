#You can easily log in as admin with email: "admin(1..5)@gmail.com" and password: "password", for example: email: "admin3@gmail.com" password: "password"
#You can easily log in as common user with email: "user(1..5)@gmail.com" and password: "password", for example: email: "user5@gmail.com" password: "password"

CATEGORIES = %w{Sport Audio Video Furniture Health Phones Computers Children House IT Food Medicine Business}
STATES = %w{published archived new}
ROLES = %w{admin user}
MODELS = %w{Advert User Comment Category Image Operation}

MODELS.each {|model| model.constantize.destroy_all}
CATEGORIES.each { |category| Category.find_or_create_by(name: category) }

ROLES.each do |role|
  2.times do |i|
    @user = User.create(name: Faker::Name.name, password: 'password', password_confirmation: 'password', email: "#{role}#{i}@gmail.com", role: role)
	p "User with password '#{@user.email}' and password '#{@user.password}' has been created"
    Advert::KINDS.each do |kind| 
	  STATES.each do |state|
	    @advert = Advert.create(name: Faker::Commerce.product_name, description: Faker::Lorem.sentence(20), price: rand(1..10000), state: state, kind: kind, user: @user, category: Category.all.sample) 
	  end
	end
  end
end

