require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @input = params[:input]
    @letters = params[:letters].split("")
    @message = ""

    @score = end_message(@input, @letters)
  end

  def check_letter(attempt, grid)
    array_attempt = attempt.upcase.chars
    array_attempt.all? do |letter|
      array_attempt.count(letter) == grid.count(letter)
    end
  end

  def check_word(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}/"
    user_serialized = URI.open(url).read
    json_check = JSON.parse(user_serialized)
    return json_check["found"]
  end

  def end_message(attempt, grid)
    if check_word(attempt) == true && check_letter(attempt, grid) == true
      @message = "Well done"
    elsif check_word(attempt) == false && check_letter(attempt, grid) == true
      @message = "not an english word"
    elsif check_word(attempt) == true && check_letter(attempt, grid) == false
      @message = "Sorry, your word is not in the grid"
    else
      @message = "Sorry, it's not an english word and it doesnt match"
    end
    return @message
  end

end
