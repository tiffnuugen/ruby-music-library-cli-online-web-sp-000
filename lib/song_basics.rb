class Song
  attr_accessor :name, :artist, :genre

  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    artist.nil? ? @artist = artist : self.artist = artist 
    self.genre = genre
  end
  
  def self.all
    @@all
  end

  def self.destroy_all
    @@all = []
  end

  def save
    @@all << self
  end
  
  def self.create(name)
    song = Song.new(name)
    song.save.last
  end  

  def artist=(artist)
    @artist = artist
    @artist.add_song(self)
  end

  def self.find_by_name(name)
    @@all.detect { |song| song.name == name }
  end

  def self.find_or_create_by_name(name)
    find_by_name(name) ? find_by_name(name) : create(name)
  end

  def self.new_from_filename(filename)
    arr = filename.split(" - ")
    name = arr[1]
    artist = Artist.find_or_create_by_name(arr[0])
    genre = Genre.find_or_create_by_name(arr[2].chomp(".mp3"))
    Song.new(name, artist, genre)
  end

  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
end


