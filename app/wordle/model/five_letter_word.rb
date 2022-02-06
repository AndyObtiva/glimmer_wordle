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
      
      attr_accessor :guesses, :guess_results, :status, :answer
      
      def initialize
        start
      end
      
      def restart
        self.guesses = []
        self.guess_results = []
        self.status = :in_progress
        self.answer = self.class.random_word
      end
      alias start restart
      
      def guess(word_guess)
        guesses << word_guess
        guess_results << guess_result_for(word_guess)
        self.status = :win if answer == guesses.last
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
    end
  end
end
