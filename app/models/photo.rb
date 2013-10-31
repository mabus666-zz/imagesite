class Photo < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	belongs_to :user

	liquid_methods :name, :thumbnail, :index, :tag_to_list, :link

	def thumbnail
		image_url(:thumb)
	end

	def tag_to_list
		tag_list
	end

	def link
		"/photos/#{id}"
	end

	def self.tagged_with(name)
		Tag.find_by_name(name).photos
	end

	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
		tags.map(&:name)
	end

	def edit_tag_list
		tags.map(&:name).join(", ")
	end

	def edit_tag_list=(names)
		self.tags = names.split(",").map do |n|
			Tag.where(name: n.strip).first_or_create!
		end
	end

end
