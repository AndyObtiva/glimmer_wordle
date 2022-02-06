require 'spec_helper'

RSpec.describe Wordle::Model::FiveLetterWord do
  it 'enables guessing 1 time and winning' do
    described_class.stub(:random_word).and_return('skill')
    
    expect(subject.guesses.count).to eq(0)
    expect(subject.guess_results.count).to eq(0)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skill')
    
    expected_result = 5.times.map {:green}
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
  end
  
  it 'refreshes five letter word after game win'
  it 'refreshes five letter word after game loss'
end
