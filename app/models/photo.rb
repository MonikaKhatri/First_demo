class Photo < ActiveRecord::Base
	belongs_to :album
	validates :name, presence: :true
	has_attached_file :pic
end
