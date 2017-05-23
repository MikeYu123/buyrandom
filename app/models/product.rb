class Product < ApplicationRecord
	audited
	has_many :auctions
	scope :by_name, ->(name) { where('lower(name) LIKE ?', "%#{name.downcase}%") }
end
