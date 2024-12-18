class Spree::Slide < ActiveRecord::Base
  has_and_belongs_to_many :slide_locations,
                          class_name: 'Spree::SlideLocation',
                          join_table: 'spree_slide_slide_locations'

  has_one_attached :image

  validates :name, :image, presence: true
  validates :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  scope :published, -> { where(published: true).order('position ASC') }
  scope :location, ->(location) { joins(:slide_locations).where('spree_slide_locations.name = ?', location) }

  acts_as_list

  STYLES = {
    preview: [120, 120],
    thumbnail: [240, 240]
  }.freeze

  def initialize(attrs = nil)
    attrs ||= { published: true }
    super
  end

  def slide_image
    image.attachment
  end

  # Helper for resizing
  def preview
    image_form(:preview)
  end

  def thumbnail
    image_form(:thumbnail)
  end

  private

  def image_form(form)
    slide_image.variant(resize_to_limit: STYLES[form])
  end
end
