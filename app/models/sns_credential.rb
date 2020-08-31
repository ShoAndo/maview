class SnsCredential < ApplicationRecord
  belongs_to :creator, optional: true
end
