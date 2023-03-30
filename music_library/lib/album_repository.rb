require_relative './album'

class AlbumRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, title, release_year, artist_id FROM albums;'
    result_set = DatabaseConnection.exec_params(sql, [])

    albums = []

    result_set.each do |record|
      album = Album.new
      album.id = record['id']
      album.title = record['title']
      album.release_year = record['release_year']
      album.artist_id = record['artist_id']

      albums << album
    end

    return albums
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

    return selected_album
  end

  def create(album)
    sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3)'
    params = [album.title, album.release_year, album.artist_id]

    DatabaseConnection.exec_params(sql, params)
  end

  def delete(id)
    sql = 'DELETE FROM albums WHERE id = $1;'
    params = [id]

    DatabaseConnection.exec_params(sql, params)
  end

  def update(album)
    sql = 'UPDATE albums SET title = $1, release_year = $2, artist_id = $3 WHERE id = $4'
    params = [album.title, album.release_year, album.artist_id, album.id]

    DatabaseConnection.exec_params(sql, params)
  end
end
