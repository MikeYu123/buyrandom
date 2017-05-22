class Operation < ApplicationRecord
  belongs_to :source, polymorphic: true
  belongs_to :destination, polymorphic: true
  belongs_to :parent, class_name: 'Operation'
  audited
end
