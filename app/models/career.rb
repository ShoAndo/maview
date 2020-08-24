class Career < ApplicationRecord
  belongs_to :creator

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :job_category
end
