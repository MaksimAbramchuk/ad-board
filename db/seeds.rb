categories = %w{Sport Audio Video Furniture Health Phones Computers Children House IT Food Medicine Business}
categories.each { |category| Category.find_or_create_by(name: category) }