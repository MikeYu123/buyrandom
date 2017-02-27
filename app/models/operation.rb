class Operation < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :destination, polymorphic: true
  audited
end
