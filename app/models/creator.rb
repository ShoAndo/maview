class Creator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  has_many :rooms
  has_many :contract
  has_one :career
  has_one :introduction
  has_one :portforio
  has_one :skill
  has_many :sns_credentials
  has_many :likes
  zenkaku = /\A[ぁ-んァ-ン一-龥]/
  kana = /\A[ァ-ヶー－]+\z/

  with_options presence: true do
    validates :first_name, :last_name, format: { with: zenkaku, message: 'は全角で入力してください。' }
    validates :kana_first_name, :kana_last_name, format: { with: kana, message: 'は全角カタカナで入力して下さい。' }
    validates :prefecture
    validates :birth_date, :prefecture
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    creator = Creator.where(email: auth.info.email).first_or_initialize(
      first_name: auth.info.name,
      email: auth.info.email
    )

    # creatorが登録済みであるか判断
    if creator.persisted?
      sns.creator = creator
      sns.creator
    end
    { creator: creator, sns: sns }
  end
end
