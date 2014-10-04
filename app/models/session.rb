class Session
	include MongoMapper::Document

	key :start, Time
	key :end, Time
    key :film_id, String
    key :cinema_id, String

	validates_presence_of :start, :end, :film_id, :cinema_id

    belongs_to :film
    belongs_to :cinema
end
