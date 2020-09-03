class Company < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_many :rooms
  has_many :contract
  has_one :outline
  has_one :card, dependent: :destroy
  has_many :company_relationships
  has_many :followings, through: :company_relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'CreatorRelationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :creator
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :name, length: {maximum: 30}
    validates :prefecture
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  def follow(other_user)
    unless self == other_user
      self.company_relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.company_relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
