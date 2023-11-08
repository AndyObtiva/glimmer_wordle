# TODO

## Next

- Include link to project in copied text upon winning, and hide word to avoid making it easy to discover words in the future.

Example:

Glimmer Wordle 183

⬜🟩⬜⬜⬜
🟨⬜⬜⬜🟨
🟩🟩🟩🟨⬜
⬜⬜⬜🟩⬜
🟩🟩🟩🟩🟩

https://github.com/AndyObtiva/glimmer_wordle

RT

#glimmer #wordle"

## Future

### Features

- Keeping history of emoji statuses (with word numbers, not the words themselves, to avoid helping people crack future words more easily)
- Ability to copy emoji statuses from history to paste/tweet

### Languages
- French language
  - Make FiveLetterWord take language as an argument
  - Parameterize allowed guesses and answers by language as English or French
  - Menu item for switching language between English and French
  - Store language in game flatfile database (yaml file)
  - Disable Qwerty option and make sure Alphabetical layout is used for all languages other than English (French)
  - Add an attribute to FiveLetterWord to change language mid-game (restaring it)
- German language
- Swedish language
- Norwegian language
- Finnish language
- Danish language
- Spanish language
- Portugese language
- Italian language
- Greek language
- Dutch language

### Platforms

- Support Windows
- Package Native Executable for Windows

### GUI Toolkits

- Port to LibUI
- Port to Tk
- Port to GTK
- Port to FOX Toolkit
- Port to Swing
- Port to JavaFX
- Port to Opal

## Maybe

- Enable users to enter letters with the mini-keyboard using mouse clicks
- Navigate between letters using mouse click
- Prevent user from entering the same 5-letter word twice (preventing repeating / repetition of a word)

## Issues

- It seems some words are missing from the original wordle dictionary of words, so consider adding them into a new file that supplants the original wordle dictionary for possible words that will not be an answer:
  - `aries`, ...
