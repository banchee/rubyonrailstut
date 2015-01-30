class Listing < ActiveRecord::Base
  if Rails.env.development?
    has_attached_file :image, 
                      :styles => { :medium => "150x150", :thumb => "50x50" }, 
                      :default_url => "default.jpg"
  else   
    has_attached_file :image, 
                      :styles => { :medium => "150x150", :thumb => "50x50" }, 
                      :default_url => "default.jpg",
                      :storage => :dropbox,
                      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                      :path => ":style/:id_:filename"
  end
  
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :name, :description, :price, presence: true
  validates :price, numericality: {greater_than: 0}
  validates_attachment_presence :image

  belongs_to :user
end
