class Event < ActiveRecord::Base
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many   :photos,    as: :parent, dependent: :restrict_with_error
  has_one    :photo_zip, as: :parent, dependent: :destroy

  validates_presence_of :name, :owner
  after_initialize :set_date
  before_create :create_permalink
  attr_readonly :photos_count

  default_scope { order('events.id DESC') }

  def to_s
    name
  end

  # TODO - Zip cache nao esta considerando quando uma foto for deletada. Ideal sera criar um campo na tabela
  # zip_cache = true quando um novo zip for criado, e false quando uma foto for adicionada ou deletada
  def zip_cache_up_to_date?
    if photo_zip.present?
      last_photo_uploaded_at = photos.order('created_at DESC').pluck(:created_at).first
      photo_zip.updated_at  >= last_photo_uploaded_at
    else
      false
    end
  end

  private
  def create_permalink
    begin
      self.permalink = SecureRandom.urlsafe_base64(8)
    end while Event.find_by(permalink: self.permalink)
  end

  def set_date
    if self.starts_at.present?
      self.starts_at = self.starts_at.strftime("%d/%m/%Y")
    end
    if self.ends_at.present?
      self.ends_at = self.ends_at.strftime("%d/%m/%Y")
    end
  end
end
