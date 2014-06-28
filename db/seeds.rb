categories = %w{Sport Audio Video Furniture Health Phones Computers Children}
categories.each { |category| Category.find_or_create_by(name: category) }
