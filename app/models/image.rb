class Image < ActiveRecord::Base

  belongs_to :advert

  has_attached_file :image, styles: { small: '150×150', large: '320×240' }
  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'], default_url: '/images/:style/missing.png'
end
