class Product < ApplicationRecord
	audited
	scope :by_name, ->(name) { where('name LIKE ?', "%#{name}%")}
end
