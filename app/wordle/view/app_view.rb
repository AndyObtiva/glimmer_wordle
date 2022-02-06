class Wordle
  module View
    class AppView
      include Glimmer::UI::CustomShell
    
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
        }
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
          # Replace example content below with custom shell content
          minimum_size 420, 240
          image File.join(APP_ROOT, 'icons', 'windows', "Wordle.ico") if OS.windows?
          image File.join(APP_ROOT, 'icons', 'linux', "Wordle.png") unless OS.windows?
          text "Wordle - App View"
          
          app_menu_bar
          
          margin_x = 15
          margin_y = 15
          @canvas = canvas {
            background :white
            
            @carets = []
            @letters = []
            5.times do |i|
              @carets << rectangle(margin_x + i*50, margin_y + 40, 40, 5) {
                background i == 0 ? :blue : :gray
                
                @letters << text('', :default, [:default, -30]) {
                  font height: 40
                }
              }
            end
            
            on_swt_keydown do |key_event|
              if key_event.keyCode == 8
                @letter = @letters.find {|letter| letter.string == ''}
                index = @letter ? @letters.index(@letter) - 1 : 4
                @letter = @letters[index]
                @letter.string = ''
                unless index == 0
                  @carets.each { |caret| caret.background = :gray}
                  @carets[index - 1].background = :blue
                end
              else
                @letter = @letters.find {|letter| letter.string == ''}
                if @letter
                  @carets.each { |caret| caret.background = :gray}
                  index = @letters.index(@letter)
                  @carets[index == 4 ? 4 : index + 1].background = :blue
                  @letter.string = key_event.keyCode.chr.upcase
                end
              end
            end
            
          }
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
          message "Wordle #{VERSION}\n\n#{LICENSE}"
        }.open
      end
    end
  end
end
