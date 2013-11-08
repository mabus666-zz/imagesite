class Photo < ActiveRecord::Base

	mount_uploader :image, ImageUploader

	validates :image, presence: true

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	belongs_to :user


	# Liquid methods
	liquid_methods :name, :index, :tag_to_list, :link, :large, :medium, :small, :thumbnail

	def thumbnail
		image_url(:thumb)
	end

	def small
		image_url(:small)
	end

	def medium
		image_url(:medium)
	end

	def large
		image_url(:large)
	end

	def tag_to_list
		tag_list
	end

	def link
		"/photos/#{id}"
	end

	def action?
		params[:action]
	end

	def paramns?
		params[:action]
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
