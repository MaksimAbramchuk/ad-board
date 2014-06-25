categories = %w{Sale Purchase Exchange Service Rent}
categories.each { |category| Category.find_or_create_by(name: category) }
