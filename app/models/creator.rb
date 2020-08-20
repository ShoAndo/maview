class Creator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  zenkaku = /\A[ぁ-んァ-ン一-龥]/
  kana = /\A[ァ-ヶー－]+\z/

  with_options presence: true do
    validates :first_name, :last_name, format: { with: zenkaku, message: 'は全角で入力してください。' }
    validates :kana_first_name, :kana_last_name, format: { with: kana, message: 'は全角カタカナで入力して下さい。' }
    validates :birth_date, :prefecture
  end

  validates :prefecture_id, numericality: { other_than: 1 }
end
