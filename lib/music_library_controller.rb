class MusicLibraryController
  attr_accessor :path, :music_importer
  
  def initialize(path='./db/mp3s')
    @path = path
    MusicImporter.new(path).import
  end
  
  def call
    user_input = ''
   while user_input != 'exit'
   puts "Welcome to your music library!"
   puts "To list all of your songs, enter 'list songs'."
   puts "To list all of the artists in your library, enter 'list artists'."
   puts "To list all of the genres in your library, enter 'list genres'."
   puts "To list all of the songs by a particular artist, enter 'list artist'."
   puts "To list all of the songs of a particular genre, enter 'list genre'."
   puts "To play a song, enter 'play song'."
   puts "To quit, type 'exit'."
   puts "What would you like to do?"
   user_input = gets.chomp
   
   case user_input
   when 'list songs'
     self.list_songs
   when 'list artists'
     self.list_artists
   when 'list genres'
     self.list_genres
   end
   end
  end
  
  def list_songs
    Song.all.sort {|x, y| x.name <=> y.name}.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end
  
  def list_artists
    Artist.all.sort {|x, y| x.name <=> y.name}.each_with_index do |artist, index|
      puts "#{index + 1}. #{artist.name}"
    end
  end
  
  def list_genres
    Genre.all.sort {|x, y| x.name <=> y.name}.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre.name}"
    end
  end
  
  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    user_input = gets.chomp
    
    if artist = Artist.find_by_name(user_input)
      artist.songs.sort {|x, y| x.name <=> y.name}.each_with_index do |song, index|
      puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end
  
  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    user_input = gets.chomp
    
     if genre = Genre.find_by_name(user_input)
      genre.songs.sort {|x, y| x.name <=> y.name}.each_with_index do |song, index|
      puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end
  
  def play_song
    puts "Which song number would you like to play?"
    user_input = gets.chomp.to_i
    songs = Song.all
    
    if (1..songs.length).include?(user_input)
      song = Song.all.sort {|x, y| x.name <=> y.name}[user_input - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end
      
end