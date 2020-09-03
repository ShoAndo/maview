class CreatorRelationship < ApplicationRecord
  belongs_to :creator
  belongs_to :follow, class_name: 'Company'

  with_options presence: true do
    validates :creator_id, :follow_id
  end
end
