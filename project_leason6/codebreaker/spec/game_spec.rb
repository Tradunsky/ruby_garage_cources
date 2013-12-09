require 'spec_helper'
require 'codebreaker/game'
require 'codebreaker/validator_matcher'

describe Codebreaker::Game do
  Game = Codebreaker::Game
  GUESS_SIZE = 4
  MAX_GUESS_NUM = 6
  MAX_ATTEMPT = 4
  let(:game) { Game.new(GUESS_SIZE, MAX_GUESS_NUM, MAX_ATTEMPT) }
  #let(:number) { GUESS_SIZE.times{ game.hint }.match(/[1-#{MAX_GUESS_NUM}]{4}/) }
  #let(:game) { Game.new }
  subject { game }    
  
  def get_number game
    number = ""
    GUESS_SIZE.times{ number += game.hint }
    number = number.match(/[1-6]{4}/).to_s
  end
  
  context ".start" do
    before do
      subject.restart
      #number = get_number
    end

    it "must have a secret code" do
      number = get_number subject
      expect(number).not_to be_empty
    end

    it "secret code must be valid", focus:true do 
      number = get_number subject
      expect(number).to match(/[1-#{MAX_GUESS_NUM}]{#{GUESS_SIZE}}/)
      #expect(number).to valid_code(GUESS_SIZE, MAX_GUESS_NUM)
    end 
    
    it "always generete new random code" do
      old_code = get_number subject
      subject.restart
      new_code = get_number subject
      expect(new_code).to_not eq(old_code)
    end
    
  end
  
  context ".guess" do
    before do
      subject.restart
    end
    
    it "return win combination if guess right" do
      number = get_number subject
      expect(subject.guess(number)).to eq "++++"
    end
    
    it "return empty string if guess does not contains right numbers" do
      expect(subject.guess("0000")).to eq ""          
    end
    
    it "result include \"+\" if guess contains right number on right position" do
      number = get_number subject
      closest_guess = number[0]+"000"
      expect(subject.guess(closest_guess)).to include("+")
    end
    
    it "result include \"-\" if guess contains right number on wrong position" do
      number = get_number subject
      closest_guess = number[1]+"000"
      expect(subject.guess(closest_guess)).to include("-")
    end    
  end
  
  context ".hint" do
  
    its(:hint) { should_not be_empty }
    
    it "result contains one digit of secret code" do
      expect(subject.hint).to match(/[1-#{MAX_GUESS_NUM}]/)
    end
    
    it "size must be eq size of secret code" do
      expect(subject.hint.size).to eq(GUESS_SIZE)
    end
    
    it "other digits must be hiding" do
      expect(subject.hint).to include("X")
    end
    
  end
    
end


