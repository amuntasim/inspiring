class User < ApplicationRecord
  NORMAL_USER_TYPE   = 'user'
  ADMIN_USER_TYPE    = 'admin'
  VALID_HANDLE_REGEX = /\A[\w+\-.]*.{4,}\z/i
  RESERVED_HANDLES   = %w(api admin dashboard users)
  has_one_attached :avatar
  has_one_attached :cover_photo

  enum user_type: [NORMAL_USER_TYPE, ADMIN_USER_TYPE]
  attr_accessor :auto_confirm

  include Permission::UserAccess
  before_validation :set_default_role, :set_handle, :if => :new_record?
  before_create :try_auto_confirm

  validates :name, presence: true
  validates :handle, presence:   true, uniqueness: true, format: {
                       with: VALID_HANDLE_REGEX, message: "Invalid!, use atleast 4 characters alphanumeric"
                   }, exclusion: { in:      RESERVED_HANDLES,
                                   message: "%{value} is reserved." }

  has_many :stories
  has_and_belongs_to_many :categories
  has_many :social_links, as: :social_linkable
  accepts_nested_attributes_for :social_links, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  def set_default_role
    self.user_type ||= NORMAL_USER_TYPE
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter]

  def name_email
    name || email
  end

  def self.create_from_provider_data(provider_data)
    where(provider_name: provider_data.provider, provider_uid: provider_data.uid).first_or_create do |user|
      user.email    = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  def net_inspiration_point
    inspiration_points - used_points_count
  end

  private

  def set_handle
    self.handle ||= get_unique_handle
  end

  def get_unique_handle
    handle_part = self.email.split("@").first
    new_handle  = handle_part.dup
    num         = 2
    until User.find_by_handle(new_handle).nil?
      new_handle = "#{handle_part}#{num}"
      num        += 1
    end
    new_handle
  end

  def try_auto_confirm
    if auto_confirm.present?
      skip_confirmation!
    end
  end
end
