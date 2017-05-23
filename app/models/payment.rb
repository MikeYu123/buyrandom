class Payment < ApplicationRecord
  belongs_to :user
  audited
end
