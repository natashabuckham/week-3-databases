require_relative './album'

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year FROM albums;

    # Returns an array of Album objects.
  end

  def find(id)
    sql = 'SELECT id, title, release_year FROM albums WHERE id = $1;'
    params = [id]
    result = DatabaseConnection.exec_params(sql, params)

    selected_album = nil

    result.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']

      selected_album = album
    end

    return "#{selected_album.title}, #{selected_album.release_year}"
  end
end
