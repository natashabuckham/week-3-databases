require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

class Application

  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository)
    DatabaseConnection.connect('music_library')
    @io = io
    @album_repository = album_repository
    # @artist_repository = artist_repository
  end

  def run
    @io.puts "Welcome to the music library manager!\n\n"
    @io.puts "What would you like to do?\n1 - List all albums\n2 - List all artists\n\nEnter your choice:"
    answer = @io.gets.chomp

    if answer == "1"
      @album_repository.all.each do |object|
      @io.puts "* #{object.id} - #{object.title}"
      end
    end
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
  )
  app.run
end
