class Track

	attr_accessor :id, :title, :url

	def initialize(attributes)
		@id    = attributes[:id]
		@title = attributes[:title]
		@url   = attributes[:url]
	end

end
