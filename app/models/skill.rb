class Skill < ApplicationRecord
  belongs_to :creator

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :level
end
