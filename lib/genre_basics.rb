class Genre
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
    genre = Genre.new(name)
    genre.save.last
  end

  def songs
    Song.all.select { |song| song.genre == self }
  end

  def artists
    songs.map { |song| song.artist }.uniq
  end
end