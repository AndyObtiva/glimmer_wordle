require 'spec_helper'

RSpec.describe Wordle::Model::FiveLetterWord do
  it 'enables guessing 1 time and winning' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    expect(subject.guesses.count).to eq(0)
    expect(subject.guess_results.count).to eq(0)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skill')
    
    expected_result = 5.times.map {:green}
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => nil,
      'f' => nil,
      'g' => nil,
      'h' => nil,
      'i' => :green,
      'j' => nil,
      'k' => :green,
      'l' => :green,
      'm' => nil,
      'n' => nil,
      'o' => nil,
      'p' => nil,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
  end
  
  it 'enables guessing 1 time and winning by typing all caps' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    expect(subject.guesses.count).to eq(0)
    expect(subject.guess_results.count).to eq(0)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('SKILL')
    
    expected_result = 5.times.map {:green}
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => nil,
      'f' => nil,
      'g' => nil,
      'h' => nil,
      'i' => :green,
      'j' => nil,
      'k' => :green,
      'l' => :green,
      'm' => nil,
      'n' => nil,
      'o' => nil,
      'p' => nil,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
  end
  
  it 'enables guessing 2 times and winning' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    result = subject.guess('shmek')
    
    expected_result = [:green, :gray, :gray, :gray, :yellow]
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => nil,
      'g' => nil,
      'h' => :gray,
      'i' => nil,
      'j' => nil,
      'k' => :yellow,
      'l' => nil,
      'm' => :gray,
      'n' => nil,
      'o' => nil,
      'p' => nil,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('shmek')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
    
    result = subject.guess('skill')

    expected_result = 5.times.map {:green}
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => nil,
      'g' => nil,
      'h' => :gray,
      'i' => :green,
      'j' => nil,
      'k' => :green,
      'l' => :green,
      'm' => :gray,
      'n' => nil,
      'o' => nil,
      'p' => nil,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(2)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(2)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
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
    
  it 'enables guessing 5 times and winning' do
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
    
    result = subject.guess('skimp')
    
    expected_result = [:green, :green, :green, :gray, :gray]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(3)
    expect(subject.guesses.last).to eq('skimp')
    expect(subject.guess_results.count).to eq(3)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('shill')
    
    expected_result = [:green, :gray, :green, :green, :green]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(4)
    expect(subject.guesses.last).to eq('shill')
    expect(subject.guess_results.count).to eq(4)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skill')

    expected_result = 5.times.map {:green}
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(5)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(5)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
  end
    
  it 'enables guessing 6 times and winning' do
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
    
    result = subject.guess('skimp')
    
    expected_result = [:green, :green, :green, :gray, :gray]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(3)
    expect(subject.guesses.last).to eq('skimp')
    expect(subject.guess_results.count).to eq(3)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skiff')
    
    expected_result = [:green, :green, :green, :gray, :gray]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(4)
    expect(subject.guesses.last).to eq('skiff')
    expect(subject.guess_results.count).to eq(4)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('shill')
    
    expected_result = [:green, :gray, :green, :green, :green]
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(5)
    expect(subject.guesses.last).to eq('shill')
    expect(subject.guess_results.count).to eq(5)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    
    result = subject.guess('skill')

    expected_result = 5.times.map {:green}
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(6)
    expect(subject.guesses.last).to eq('skill')
    expect(subject.guess_results.count).to eq(6)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:win)
  end
    
  it 'enables guessing 6 times and losing' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    result = subject.guess('shmoe')
    
    expected_result = [:green, :gray, :gray, :gray, :gray]
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => nil,
      'g' => nil,
      'h' => :gray,
      'i' => nil,
      'j' => nil,
      'k' => nil,
      'l' => nil,
      'm' => :gray,
      'n' => nil,
      'o' => :gray,
      'p' => nil,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
    
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(1)
    expect(subject.guesses.last).to eq('shmoe')
    expect(subject.guess_results.count).to eq(1)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
    
    result = subject.guess('shmek')
    
    expected_result = [:green, :gray, :gray, :gray, :yellow]
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => nil,
      'g' => nil,
      'h' => :gray,
      'i' => nil,
      'j' => nil,
      'k' => :yellow,
      'l' => nil,
      'm' => :gray,
      'n' => nil,
      'o' => :gray,
      'p' => nil,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
        
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(2)
    expect(subject.guesses.last).to eq('shmek')
    expect(subject.guess_results.count).to eq(2)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
    
    result = subject.guess('skimp')
    
    expected_result = [:green, :green, :green, :gray, :gray]
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => nil,
      'g' => nil,
      'h' => :gray,
      'i' => :green,
      'j' => nil,
      'k' => :green,
      'l' => nil,
      'm' => :gray,
      'n' => nil,
      'o' => :gray,
      'p' => :gray,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
         
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(3)
    expect(subject.guesses.last).to eq('skimp')
    expect(subject.guess_results.count).to eq(3)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
    
    result = subject.guess('skiff')
    
    expected_result = [:green, :green, :green, :gray, :gray]
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => :gray,
      'g' => nil,
      'h' => :gray,
      'i' => :green,
      'j' => nil,
      'k' => :green,
      'l' => nil,
      'm' => :gray,
      'n' => nil,
      'o' => :gray,
      'p' => :gray,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
             
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(4)
    expect(subject.guesses.last).to eq('skiff')
    expect(subject.guess_results.count).to eq(4)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
    
    result = subject.guess('shill')
    
    expected_result = [:green, :gray, :green, :green, :green]
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => :gray,
      'g' => nil,
      'h' => :gray,
      'i' => :green,
      'j' => nil,
      'k' => :green,
      'l' => :green,
      'm' => :gray,
      'n' => nil,
      'o' => :gray,
      'p' => :gray,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => nil,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
                 
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(5)
    expect(subject.guesses.last).to eq('shill')
    expect(subject.guess_results.count).to eq(5)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:in_progress)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
    
    result = subject.guess('skull')

    expected_result = [:green, :green, :gray, :green, :green]
    expected_colored_alphabets = {
      'a' => nil,
      'b' => nil,
      'c' => nil,
      'd' => nil,
      'e' => :gray,
      'f' => :gray,
      'g' => nil,
      'h' => :gray,
      'i' => :green,
      'j' => nil,
      'k' => :green,
      'l' => :green,
      'm' => :gray,
      'n' => nil,
      'o' => :gray,
      'p' => :gray,
      'q' => nil,
      'r' => nil,
      's' => :green,
      't' => nil,
      'u' => :gray,
      'v' => nil,
      'w' => nil,
      'x' => nil,
      'y' => nil,
      'z' => nil,
    }
         
    expect(result).to eq(expected_result)
    expect(subject.guesses.count).to eq(6)
    expect(subject.guesses.last).to eq('skull')
    expect(subject.guess_results.count).to eq(6)
    expect(subject.guess_results.last).to eq(expected_result)
    expect(subject.status).to eq(:loss)
    expect(subject.colored_alphabets).to eq(expected_colored_alphabets)
  end
  
  it 'returns nil for guessing after game win' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    subject.guess('skill')
    result = subject.guess('skill')
    
    expect(result).to be_empty
    expect(subject.status).to eq(:win)
  end
  
  it 'returns nil for guessing after game loss' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    subject.guess('shmoe')
    
    subject.guess('shmek')
    
    subject.guess('skimp')
    
    subject.guess('skiff')
    
    subject.guess('shill')
    
    subject.guess('skull')

    result = subject.guess('skill')
    
    expect(result).to be_empty
    expect(subject.status).to eq(:loss)
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
  
  it 'refreshes five letter word after game loss' do
    allow(described_class).to receive(:random_word) {'skill'}
    
    subject.guess('shmoe')
    
    subject.guess('shmek')
    
    subject.guess('skimp')
    
    subject.guess('skiff')
    
    subject.guess('shill')
    
    subject.guess('skull')

    expect(subject.status).to eq(:loss)
    
    allow(described_class).to receive(:random_word) {'abbot'}
    
    subject.refresh

    result = subject.guess('abbot')
    
    expect(subject.status).to eq(:win)
  end
end
