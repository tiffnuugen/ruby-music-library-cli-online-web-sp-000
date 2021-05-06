class Artist
  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name 
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
    artist = Artist.new(name)
    artist.save.last
  end
  
  def add_song(song)
    song.artist.nil? && song.artist = self
  end

  def songs
    Song.all.select { |song| song.artist == self }
  end

  def genres
    songs.map { |song| song.genre }.uniq
  end
end
