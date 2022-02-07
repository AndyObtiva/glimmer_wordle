class Wordle
  module View
    class AppView
      include Glimmer::UI::CustomShell
      
      COLOR_TO_BACKGROUND_COLOR_MAP = {
        green:  :dark_green,
        yellow: :dark_yellow,
        gray:   :dark_gray,
      }
      
      COLOR_TO_TEXT_COLOR_MAP = {
        green:  :white,
        yellow: :white,
        gray:   :white,
      }
    
      ## Add options like the following to configure CustomShell by outside consumers
      #
      # options :title, :background_color
      # option :width, default: 320
      # option :height, default: 240
      option :greeting, default: 'Hello, World!'
  
      ## Use before_body block to pre-initialize variables to use in body
      #
      #
      before_body do
        Display.app_name = 'Wordle'
        Display.app_version = VERSION
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
            elsif key_event.keyCode == swt(:cr) && word_filled_up?
              do_guess
            elsif valid_character?(key_event.keyCode.chr)
              do_type(key_event.keyCode.chr)
            end
          end
        }
        @five_letter_word = Model::FiveLetterWord.new
        pd @five_letter_word.answer
      end
  
      ## Use after_body block to setup observers for widgets in body
      #
      # after_body do
      #
      # end
  
      ## Add widget content inside custom shell body
      ## Top-most widget must be a shell or another custom shell
      #
      body {
        shell {
          grid_layout {
            margin_width 10
            margin_height 10
            vertical_spacing 0
          }
          
          # Replace example content below with custom shell content
          minimum_size 420, 343
          image File.join(APP_ROOT, 'icons', 'windows', "Wordle.ico") if OS.windows?
          image File.join(APP_ROOT, 'icons', 'linux', "Wordle.png") unless OS.windows?
          text "Glimmer Wordle"
          background :white
          
          app_menu_bar
          
          word_guesser
        }
      }
      
      def app_menu_bar
        menu_bar {
          menu {
            text '&Help'
            
            menu_item {
              text '&About...'
              on_widget_selected {
                display_about_dialog
              }
            }
          }
        }
      end
  
      def display_about_dialog
        message_box(body_root) {
          text 'About'
          message "Glimmer Wordle #{VERSION}\n\n#{LICENSE}"
        }.open
      end
      
      def word_guesser
        margin_x = 5
        margin_y = 5
        @canvas = canvas {
          layout_data(:center, :center, true, false) {
            width_hint 230
            height_hint 50
          }
          background :white
          
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
                font height: 40
              }
            }
          end
        }
      end
      
      def do_backspace
        @letter = @letters.find {|letter| letter.string == ''}
        index = @letter ? @letters.index(@letter) - 1 : 4
        @letter = @letters[index]
        @letter.string = ''
        if index > 0
          @borders.each { |caret| caret.foreground = :gray}
          @borders[index - 1].foreground = :title_background
        end
      end
      
      def do_guess
        word = @letters.map(&:string).join
        guess_result = @five_letter_word.guess(word)
        guess_result.each_with_index do |result_color, i|
          background_color = COLOR_TO_BACKGROUND_COLOR_MAP[result_color]
          @borders[i].foreground = background_color
          @rectangles[i].background = background_color
          @letters[i].foreground = COLOR_TO_TEXT_COLOR_MAP[result_color]
          @canvas.redraw
        end
        if @five_letter_word.status == :in_progress
          body_root.content { word_guesser }
          body_root.layout(true, true)
          body_root.pack(true)
        end
      end
      
      def do_type(character)
        @letter = @letters.find {|letter| letter.string == ''}
        index = @letters.index(@letter)
        if @letter
          @borders.each { |caret| caret.foreground = :gray}
          @borders[index == 4 ? 4 : index + 1].foreground = :title_background
          @letter.string = character.upcase
        end
      end
      
      def word_filled_up?
        @letters.find {|letter| letter.string == ''}.nil?
      end
      
      def valid_character?(character)
        ((65..90).to_a + (97..122).to_a).map {|n| n.chr}.include?(character)
      end
    end
  end
end
