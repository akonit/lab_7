class Film
	include MongoMapper::Document

	key :name, String
	key :description, String

	key :session_ids, Array
    many :sessions, :in => :session_ids

	validates_presence_of :name, :description
end
