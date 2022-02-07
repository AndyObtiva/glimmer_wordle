$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

begin
  require 'bundler/setup'
  Bundler.require(:default)
rescue
  # this runs when packaged as a gem (no bundler)
  require 'glimmer-dsl-swt'
  # add more gems if needed
end

Clipboard.implementation = Clipboard::Java
Clipboard.copy(Clipboard.paste) # pre-initialize library to avoid slowdown during use

class Wordle
  include Glimmer
  
  APP_ROOT = File.expand_path('../..', __FILE__)
  VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
  LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
  
  Display.app_name = 'Glimmer Wordle'
  Display.app_version = VERSION
end

require 'wordle/model/five_letter_word'
require 'wordle/view/app_view'
