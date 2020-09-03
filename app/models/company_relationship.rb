class CompanyRelationship < ApplicationRecord
  belongs_to :company
  belongs_to :follow, class_name: 'Creator'

  with_options presence: true do
    validates :company_id, :follow_id
  end
end
