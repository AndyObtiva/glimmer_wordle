class Wordle
  module View
    class AppView
      include Glimmer::UI::CustomShell
      
      COLOR_TO_BACKGROUND_COLOR_MAP = {
        green:  rgb(106, 170, 100),
        yellow: rgb(201, 180, 88),
        gray:   rgb(120, 124, 126),
      }
      
      COLOR_TO_TEXT_COLOR_MAP = {
        green:  :white,
        yellow: :white,
        gray:   :white,
      }
      
      ALPHABET_LAYOUTS = {
        alphabetical: [
          %w[A B C D E F G H I J],
          %w[K L M N O P Q R S],
          %w[T U V W X Y Z],
        ],
        qwerty: [
          %w[Q W E R T Y U I O P],
          %w[A S D F G H J K L],
          %w[Z X C V B N M],
        ],
      }
      
      CONFIG_FILE = File.join(Dir.home, '.glimmer_wordle')
    
      before_body do
        @display = display {
          on_about {
            display_about_dialog
          }
          on_preferences {
            display_about_dialog
          }
          on_swt_keydown do |key_event|
            if key_event.keyCode == 8
              do_backspace
            elsif key_event.keyCode == swt(:arrow_left)
              do_left
            elsif key_event.keyCode == swt(:arrow_right)
              do_right
            elsif key_event.keyCode == swt(:cr)
              if @five_letter_word.status == :in_progress
                do_guess
              else
                do_restart
              end
            elsif valid_character?((key_event.keyCode.chr rescue ''))
              do_type(key_event.keyCode.chr)
            end
          end
        }
        @five_letter_word = Model::FiveLetterWord.new
        config = load_config
        @alphabet_layout = config[:alphabet_layout] || :alphabetical
      end
  
      ## Add widget content inside custom shell body
      ## Top-most widget must be a shell or another custom shell
      #
      body {
        shell(:no_resize) {
          grid_layout {
            margin_width 10
            margin_height 10
            vertical_spacing 0
          }
          
          # Replace example content below with custom shell content
          minimum_size 420, 540
          image File.join(APP_ROOT, 'icons', 'windows', "Glimmer Wordle.ico") if OS.windows?
          image File.join(APP_ROOT, 'icons', 'linux', "Glimmer Wordle.png") unless OS.windows?
          text "Glimmer Wordle"
          background :white
          
          app_menu_bar
          
          alphabet_container
          
          label {
            layout_data :center, :center, true, false
            text 'You have 6 tries to guess a 5-letter word'
          }
          
          word_guesser
          
          guess_button
        }
      }
      
      def app_menu_bar
        menu_bar {
          menu {
            text '&Game'
            
            menu_item {
              text '&Restart'
              
              on_widget_selected {
                do_restart
              }
            }
            
            menu_item {
              text 'E&xit'
              
              on_widget_selected {
                exit(0)
              }
            }
          }
          
          menu {
            text '&View'
            
            menu {
              text 'Alphabet &Layout'
              
              menu_item(:radio) {
                text '&Alphabetical'
                selection @alphabet_layout == :alphabetical
                
                on_widget_selected {
                  self.alphabet_layout = :alphabetical
                  rebuild_alphabet_container
                }
              }
              
              menu_item(:radio) {
                text '&Qwerty'
                selection @alphabet_layout == :qwerty
                
                on_widget_selected {
                  self.alphabet_layout = :qwerty
                  rebuild_alphabet_container
                }
              }
            }
          }
          
          menu {
            text '&Help'
            
            menu_item {
              text '&Instructions'
              
              on_widget_selected {
                display_instructions_dialog
              }
            }
            
            menu_item {
              text '&About'
              
              on_widget_selected {
                display_about_dialog
              }
            }
          }
        }
      end
  
      def display_instructions_dialog
        message_box(body_root) {
          text 'Instructions'
          message <<~MULTI_LINE_STRING
            Glimmer Wordle Instructions
            
            Make 6 guesses for a 5-letter word.
            
            If you enter a letter that is part of the word,
            and at the right location in the word,
            the letter will become green.
            
            If you enter a letter that is part of the word,
            but at the wrong location in the word,
            the letter will become yellow.
            
            If you enter a letter that is not part of the word,
            the letter will become red.
            
            If you win or lose, you get to see the answer,
            and share the result emojis.
            
            Happy Glimmer Wordle!
          MULTI_LINE_STRING
        }.open
      end
      
      def display_about_dialog
        message_box(body_root) {
          text 'About'
          message "Glimmer Wordle #{VERSION}\n\n#{LICENSE}"
        }.open
      end
      
      def alphabet_container
        @alphabet_container = composite {
          layout_data(:center, :center, true, false)
          
          grid_layout {
            margin_width 0
            margin_height 0
            vertical_spacing 0
          }
          
          background :white
        
          alphabets
        }
      end
      
      def alphabets
        alphabet_row(ALPHABET_LAYOUTS[@alphabet_layout][0]) {
          layout_data(:center, :center, true, false) {
            width_hint 318
            height_hint 50
          }
        }
        
        alphabet_row(ALPHABET_LAYOUTS[@alphabet_layout][1]) {
          layout_data(:center, :center, true, false) {
            width_hint 288
            height_hint 50
          }
        }
        
        alphabet_row(ALPHABET_LAYOUTS[@alphabet_layout][2]) {
          layout_data(:center, :center, true, false) {
            width_hint 222
            height_hint 50
          }
        }
      end
      
      def alphabet_row(alphabet_characters, &block)
        canvas {
          block.call
          background :white
          
          @alphabet_rectangles ||= []
          @alphabet_borders ||= []
          @alphabet_letters ||= []
          alphabet_characters.each_with_index do |alphabet_character, i|
            @alphabet_rectangles << rectangle(1 + i*32, @alphabet_row_offset_y, 28, 28) {
              background :transparent
              
              @alphabet_borders << rectangle {
                foreground :gray
                line_width 2
              }
              
              @alphabet_letters << text(alphabet_character) {
                font style: :bold, height: 28
              }
            }
          end
        }
      end
      
      def alphabet_layout_alphabets
        ALPHABET_LAYOUTS[@alphabet_layout].reduce(:+)
      end
      
      def word_guesser
        @canvasses ||= []
        margin_x = 5
        margin_y = 5
        @canvasses << canvas {
          layout_data(:center, :center, true, false) {
            width_hint 230
            height_hint 50
          }
          background :white
          focus true
          
          @rectangles = []
          @borders = []
          @letters = []
          5.times do |i|
            @rectangles << rectangle(margin_x + i*45, margin_y, 40, 40) {
              background :transparent
              
              @borders << rectangle {
                foreground i == 0 ? :title_background : :gray
                line_width 2
              }
              
              @letters << text('') {
                font style: :bold, height: 40
              }
            }
          end
        }
      end
      
      def guess_button
        @guess_button = button {
          layout_data :center, :center, true, false
          text 'Guess'
          
          on_widget_selected do
            do_guess
          end
        }
      end
      
      def do_backspace
        @letter = @letters.find {|letter| letter.string == ''}
        index = @letter ? [@letters.index(@letter) - 1, 0].max : 4
        @letter = @letters[index]
        @letter.string = ''
        @borders.each { |caret| caret.foreground = :gray}
        @borders[index].foreground = :title_background
      end
      
      def do_guess
        return if !word_filled_up?
        word = @letters.map(&:string).join
        if invalid_word?(word)
          message_box {
            text 'Invalid Word'
            message "The word you entered is not an allowed guess!\n\nPlease try another word!"
          }.open
          return
        end
        guess_result = @five_letter_word.guess(word)
        update_guess_word_background_colors(guess_result)
        update_alphabet_background_colors
        if @five_letter_word.status == :in_progress
          @guess_button.dispose
          body_root.content {
            word_guesser
            guess_button
          }
        else
          @guess_button.dispose
          body_root.content {
            @restart_button = button {
              layout_data :center, :center, true, false
              text 'Restart'
              focus true
              
              on_widget_selected do
                do_restart
              end
            }
          }
          display_share_text_dialog
        end
        body_root.layout(true, true)
        body_root.pack(true)
      end
      
      def highlighted_letter_index
        @borders.each_with_index.find {|border, i| border.foreground.first == color(:title_background).swt_color }.last
      end
      
      def do_type(character)
        index = highlighted_letter_index
        @letter = @letters[index]
        @letter.string = character.upcase
        if @letters.any? {|letter| letter.string == ''}
          @borders.each { |caret| caret.foreground = :gray}
          @borders[index == 4 ? 4 : index + 1].foreground = :title_background
        end
      end
      
      def do_left
        index = [highlighted_letter_index - 1, 0].max
        @borders.each { |caret| caret.foreground = :gray}
        @borders[index].foreground = :title_background
      end
      
      def do_right
        index = [highlighted_letter_index + 1, @letters.count - 1].min
        @borders.each { |caret| caret.foreground = :gray}
        @borders[index].foreground = :title_background
      end
      
      def do_restart
        @share_text_dialog&.close
        alphabet_layout_alphabets.each_with_index do |alphabet_character, i|
          @alphabet_borders[i].foreground = :gray
          @alphabet_rectangles[i].background = :white
          @alphabet_letters[i].foreground = :black
        end
        @restart_button&.dispose
        @canvasses.dup.each(&:dispose)
        @canvasses.clear
        @guess_button&.dispose
        body_root.content {
          word_guesser
          guess_button
        }
        body_root.layout(true, true)
        body_root.pack(true)
        @five_letter_word.refresh
      end
      
      def update_guess_word_background_colors(guess_result)
        guess_result.each_with_index do |result_color, i|
          background_color = COLOR_TO_BACKGROUND_COLOR_MAP[result_color]
          @borders[i].foreground = background_color
          @rectangles[i].background = background_color
          @letters[i].foreground = COLOR_TO_TEXT_COLOR_MAP[result_color]
          async_exec { @canvasses.last.redraw }
        end
      end
      
      def update_alphabet_background_colors
        alphabet_layout_alphabets.each_with_index do |alphabet_character, i|
          result_color = @five_letter_word.colored_alphabets[alphabet_character.downcase]
          if result_color
            background_color = COLOR_TO_BACKGROUND_COLOR_MAP[result_color]
            @alphabet_borders[i].foreground = background_color
            @alphabet_rectangles[i].background = background_color
            @alphabet_letters[i].foreground = COLOR_TO_TEXT_COLOR_MAP[result_color]
          end
        end
      end
      
      def word_filled_up?
        @letters.find {|letter| letter.string == ''}.nil?
      end
      
      def invalid_word?(word)
        !Model::FiveLetterWord::WORLD_ALLOWED_GUESSES.include?(word.downcase)
      end
      
      def valid_character?(character)
        ((65..90).to_a + (97..122).to_a).map {|n| n.chr}.include?(character)
      end
      
      def display_share_text_dialog
        result = "#{@five_letter_word.answer.upcase}\n\n#{emoji_result}"
          
        Clipboard.copy(result)

        @share_text_dialog = dialog(body_root) {
          grid_layout
          text 'Share Result'
          
          app_menu_bar
          
          label {
            layout_data :center, :center, true, false
            text 'Result is copied to clipboard!'
          }
          
          styled_text {
            layout_data :fill, :fill, true, true
            editable false
            caret nil
            alignment :center
            text result
          }
        }
        @share_text_dialog.open
      end
      
      def dispose_alphabet_container_children
        @alphabet_rectangles.clear
        @alphabet_borders.clear
        @alphabet_letters.clear
        @alphabet_container.children.each(&:dispose)
      end
      
      def rebuild_alphabet_container
        dispose_alphabet_container_children
        @alphabet_container.content {
          alphabets
        }
        @alphabet_container.layout(true, true)
        @alphabet_container.pack(true)
      end
      
      def alphabet_layout=(value)
         @alphabet_layout = value
         save_config
      end
      
      def new_config
        {
          alphabet_layout: @alphabet_layout
        }
      end
      
      def save_config
        File.write(CONFIG_FILE, YAML.dump(new_config))
      rescue => e
        puts e.full_message
      end
      
      def load_config
        File.exist?(CONFIG_FILE) ? YAML.load(File.read(CONFIG_FILE)) : {}
      rescue => e
        puts e.full_message
        {}
      end
      
      def emoji_result
        result = ''
        @five_letter_word.guess_results.each do |row|
          row.each do |result_color|
            case result_color
            when :green
              result << "🟩"
            when :yellow
              result << "🟨"
            when :gray
              result << "⬜"
            end
          end
          result << "\n"
        end
        result
      end
    end
  end
end
