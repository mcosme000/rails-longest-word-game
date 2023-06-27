require 'open-uri'

class GamesController < ApplicationController

  VOWELS = ['A', 'E', 'I', 'O', 'U']

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) {(('A'..'Z').to_a - VOWELS).sample}
    @letters.shuffle!
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
