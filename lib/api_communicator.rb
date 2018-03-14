
require 'rest-client'
require 'json'
require 'pry'


def get_character_movies_from_api(character)
  # make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  characters = character_hash["results"]
  filmInfo = []

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


#
# BONUS ADJUSMENTS - IN PROGRESS
#
# def make_web_request(character)
#   character_found = nil
#   page_number = 1
#   end_pages = nil
#   until character_found # WHAT IF IT NEVER FINDS? WHEN DOES IT STOP LOOKING THROUGH PAGES
#     all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{page_number}")
#     character_hash = JSON.parse(all_characters)
#     characters = character_hash["results"]
#     end_pages = characters["detail"]
#
#     character_found = characters.find do |hash|
#       hash["name"] == character
#     end
#     page_number += 1
#   end
#   character_found
# end
#
#
#
# def get_character_movies_from_api(character)
#   character = make_web_request(character)
#   filmInfo = []
#     character["films"].each do |url|
#         film = RestClient.get(url)
#         filmHash = JSON.parse(film)
#         filmInfo << filmHash
#     end
#   filmInfo
# end
#
# def parse_character_movies(films_hash)
#   films_hash.each do |film|
#     puts "***************************"
#     puts "Title: " + film["title"]
#     puts "Director: " + film["director"]
#     puts "Producer: " + film["producer"]
#     puts "Release Date: " + film["release_date"]
#   end
# end
#
# def show_character_movies(character)
#   films_hash = get_character_movies_from_api(character)
#   parse_character_movies(films_hash)
# end
