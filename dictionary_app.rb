 require "http"
 require "awesome_print"

 puts "To start, enter a word:"
@word = gets.chomp
@response_definition = HTTP.get("https://api.wordnik.com/v4/word.json/#{@word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=03pgsw5yqhr4za5ql3604lcnwwdhwyznzog38048pue6ca6qy").parse(:json)
@response_pronunciation = HTTP.get("https://api.wordnik.com/v4/word.json/#{@word}/pronunciations?useCanonical=false&limit=50&api_key=03pgsw5yqhr4za5ql3604lcnwwdhwyznzog38048pue6ca6qy").parse(:json)

def get_definition
  i = 0
  while i < @response_definition.length
    if @response_definition[i].has_key?("text") == true
      @definition = @response_definition[i]["text"]
      break
    else
      i += 1
    end
  end
  return @definition
end

def get_pronunciation
  i = 0
  while i < @response_pronunciation.length
    if @response_pronunciation[i].has_key?("raw") == true
      @pronunciation = @response_pronunciation[i]["raw"]
      break
    else
      i += 1
    end
  end
  return @pronunciation
end

puts get_definition
puts get_pronunciation
puts ""

while true
  puts "Enter another word (or q to quit):"
  @word = gets.chomp
  if 
    @word == "q"
    puts "Goodbye"
    break
  else
    puts "Definition: #{get_definition}"
    puts "Pronunciation: #{get_pronunciation}"
    puts ""
  end
end

# # response_audio = HTTP.get("https://api.wordnik.com/v4/word.json/computer/audio?useCanonical=false&limit=50&api_key=03pgsw5yqhr4za5ql3604lcnwwdhwyznzog38048pue6ca6qy").parse(:json)
# # # p response_audio.class
# ap response_audio[0]