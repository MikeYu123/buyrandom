class Operation < ApplicationRecord
  belongs_to :source
  belongs_to :destination
  audited
end
