class Photo < ActiveRecord::Base
  acts_as_taggable
  belongs_to :parent, polymorphic: true, counter_cache: true
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id', counter_cache: true

  validates_presence_of :owner, :photo
  validates_uniqueness_of :original_filename, scope: [:parent]

  mount_uploader :photo, PhotoUploader

  default_scope { order('photos.original_filename ASC') }
end
