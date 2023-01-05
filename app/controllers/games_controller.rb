require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters.push(('A'..'Z').to_a.sample) }
  end

  def score
    @letters = params[:letters]
    @attempt = params[:attempt]
    url = "https://wagon-dictionary.herokuapp.com/#{params[:attempt]}"
    @data = JSON.parse(URI.open(url).read)

    # check if english word
    @english_word = @data['found'] == true

    # check if included in original array
    @included = @attempt.upcase.chars.all? { |letter| @letters.include?(letter) }

    # @attempt.upcase.chars.all? { |letter| @attempt.count(letter) <= @letters.count(letter) }
  end
end
