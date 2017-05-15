class Product < ApplicationRecord
	audited
	scope :by_name, ->(name) { where('lower(name) LIKE ?', "%#{name.downcase}%") }
end
