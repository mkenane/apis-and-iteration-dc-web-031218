
require 'rest-client'
require 'json'
require 'pry'
def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  characters = character_hash["results"]
  filmInfo = []
    #When key == "name"
  characters.find do |hash|#array
      hash["name"] == character
          end["films"].each do |url|
            film = RestClient.get(url)
            filmHash = JSON.parse(film)
            filmInfo << filmHash
        end
  filmInfo
end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    puts "***************************"
    puts "Title: " + film["title"]
    puts "Director: " + film["director"]
    puts "Producer: " + film["producer"]
    puts "Release Date: " + film["release_date"]
  end
end
def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
