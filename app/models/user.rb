class User < ApplicationRecord
  NORMAL_USER_TYPE = 'user'
  ADMIN_USER_TYPE = 'admin'
  has_one_attached :avatar
  has_one_attached :cover_photo

  enum user_type: [NORMAL_USER_TYPE, ADMIN_USER_TYPE]
  attr_accessor :auto_confirm

  include Permission::UserAccess
  after_initialize :set_default_role, :if => :new_record?
  before_create :try_auto_confirm

  has_many :stories
  has_many :social_links, as: :social_linkable
  accepts_nested_attributes_for :social_links, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  def set_default_role
    self.user_type ||= NORMAL_USER_TYPE
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers =>  [:facebook, :google_oauth2, :twitter]


  def name_email
    name || email
  end

  def self.create_from_provider_data(provider_data)
    where(provider_name: provider_data.provider, provider_uid: provider_data.uid).first_or_create do | user |
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  private

  def try_auto_confirm
    if auto_confirm.present?
      skip_confirmation!
    end
  end
end
