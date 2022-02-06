require 'spec_helper'

RSpec.describe Wordle::Model::FiveLetterWord do
  it 'enables guessing 1 time and winning' do
    allow(described_class).to receive(:random_word) {'skill'}
    
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
    # TODO check the keyboard alphabet colors too
  end
  
  it 'enables guessing 2 times and winning' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    result = subject.guess('shmek')
    
    expected_result = [:green, :gray, :gray, :gray, :yellow]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('shmek')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skill')

    expected_result = 5.times.map {:green}
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(2)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(2)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
  end
  
  it 'enables guessing 3 times and winning' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    result = subject.guess('shmek')
    
    expected_result = [:green, :gray, :gray, :gray, :yellow]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('shmek')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('shill')
    
    expected_result = [:green, :gray, :green, :green, :green]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(2)
    expect(subject.guesses.last).to eq('shill')
    expect(subject.guess_results.count).to eq(2)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skill')

    expected_result = 5.times.map {:green}
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(3)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(3)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
  end
  
  it 'enables guessing 4 times and winning' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    result = subject.guess('shmoe')
    
    expected_result = [:green, :gray, :gray, :gray, :gray]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('shmoe')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('shmek')
    
    expected_result = [:green, :gray, :gray, :gray, :yellow]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(2)
    expect(subject.guesses.last).to eq('shmek')
    expect(subject.guess_results.count).to eq(2)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('shill')
    
    expected_result = [:green, :gray, :green, :green, :green]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(3)
    expect(subject.guesses.last).to eq('shill')
    expect(subject.guess_results.count).to eq(3)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skill')

    expected_result = 5.times.map {:green}
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(4)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(4)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
  end
    
  it 'refreshes five letter word after game win' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    result = subject.guess('skill')
    
    allow(described_class).to receive(:random_word) {'abbot'}
    
    subject.refresh
    
    result = subject.guess('abbot')
    
    expect(subject.guesses.last).to eq('abbot')
    expect(subject.status).to eq(:win)
  end
  it 'refreshes five letter word after game loss'
end
