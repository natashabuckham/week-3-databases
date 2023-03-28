require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library') # here we are calling a class method, so we don't have to create an instance
# of DatabaseConnection, we are calling the method directly on the class itself. We only want one connection to exist at a time,
# so don't need to create many instances of the class.

artist_repository = ArtistRepository.new

artist_repository.all.each do |artist|
  p artist
end
