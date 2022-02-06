class Wordle
  module Model
    class FiveLetterWord
      class << self
        def random_word
          WORLD_ANSWERS_ALPHABETICAL.sample
        end
      end
      
      WORLD_ANSWERS_ALPHABETICAL_FILE = File.join(APP_ROOT, 'config', 'wordle-answers-alphabetical.txt')
      WORLD_ALLOWED_GUESSES_FILE = File.join(APP_ROOT, 'config', 'wordle-allowed-guesses.txt')
      WORLD_ANSWERS_ALPHABETICAL = File.read(WORLD_ANSWERS_ALPHABETICAL_FILE).lines(chomp: true).sort
      WORLD_ALLOWED_GUESSES = (WORLD_ANSWERS_ALPHABETICAL + File.read(WORLD_ALLOWED_GUESSES_FILE).lines(chomp: true)).sort
      COLORS = [:green, :yellow, :gray]
      STATUSES = [:in_progress, :win, :loss]
      
      attr_accessor :guesses, :guess_results, :status, :answer, :colored_alphabets
      
      def initialize
        refresh
      end
      
      def refresh
        self.guesses = []
        self.guess_results = []
        self.status = :in_progress
        self.answer = self.class.random_word
        self.colored_alphabets = (97..122).map {|n| n.chr}.reduce({}) {|hash, letter| hash.merge(letter => nil) }
      end
      
      def guess(word_guess)
        word_guess = word_guess.downcase
        return [] if status == :win || status == :loss
        guesses << word_guess
        guess_results << guess_result_for(word_guess)
        update_colored_alphabets(word_guess, guess_results.last)
        self.status = :win if guesses.last == answer
        self.status = :loss if guesses.last != answer && guesses.count == 6
        guess_results.last
      end
      
      private
      
      def guess_result_for(word_guess)
        5.times.map do |i|
          if answer[i] == word_guess[i]
            :green
          elsif answer.include?(word_guess[i])
            :yellow
          else
            :gray
          end
        end
      end
      
      def update_colored_alphabets(word_guess, guess_result)
        5.times do |i|
          if guess_result[i] == :green
            self.colored_alphabets[word_guess[i]] = :green
          elsif guess_result[i] == :yellow
            self.colored_alphabets[word_guess[i]] = :yellow if self.colored_alphabets[word_guess[i]] != :green
          elsif guess_result[i] == :gray
            self.colored_alphabets[word_guess[i]] = :gray if self.colored_alphabets[word_guess[i]].nil?
          end
        end
      end
    end
  end
end
