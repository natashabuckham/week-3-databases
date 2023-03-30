require_relative '../app'
require_relative '../lib/album_repository'

RSpec.describe Application do
  it "returns the list of albums" do
    io = double :io
    # album_repository = double :album_repository, all:

    expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n").ordered
    expect(io).to receive(:puts).with("What would you like to do?\n1 - List all albums\n2 - List all artists\n\nEnter your choice:").ordered
    expect(io).to receive(:gets).and_return("1").ordered
    expect(io).to receive(:puts).and_return("* 1 - Something else\n* 2 - Surfer Rosa\n* 3 - Waterloo\n* 4 - Super Trooper").ordered

    application = Application.new('music_library_test', io, AlbumRepository.new)
    application.run
  end
end


# str.split("\n")

