class User < ActiveRecord::Base
	acts_as_tagger
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_many :events
  has_many :photos, dependent: :destroy
  default_scope { order('users.id DESC') }

  DEFAULT_PASSWORD  = '123mudar'
  DEFAULT_API_EMAIL = 'api@carrierwave-s3-upload-test.com.br'
  DEFAULT_USER_EMAIL = 'user@carrierwave-s3-upload-test.com.br'

  def to_s
  	"#{id} | #{email}"
  end
end
