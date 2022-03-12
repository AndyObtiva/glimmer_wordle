# Change Log

## 1.2.0

- Correct spelling of querty as qwerty
- Shorten help instructions to fit vertically in Monterey/Big-Sur style message box

## 1.1.1

- Fix issue with loading `clipboard` gem when running `glimmer_wordle` command from Ruby gem.

## 1.1.0

- Display answer when losing
- Close Share Emoji dialog when restarting game (with ENTER button or menu item)
- Have the main app menu bar show up in the Share Emoji dialog
- Add Help menu Instructions menu item
- Change default alphabet layout to be alphabetical (i.e. abcd...) instead of querty (since users will not be tapping like in cell phones yet using a real keyboard)
- Offer View -> Alphabet Layout menu item options of Alphabetical or Querty (storing in config file `~/.glimmer_wordle`)
- Adjust the dark yellow (to #c9b458), dark green (to #6aaa64), and dark gray (to rgb 120 124 126) colors to match the original Wordle game colors
- Support overriding a letter with typing in highlighted letter position
- Navigate letters with left and right keyboard buttons and re-enter a letter (without having to use backspace)
- Fix an issue with backspacing all the way back to the first character after only typing one character causing rectangle highlight not to move back to first letter
- Fix issue where upon restart, the guess button is showing above the entry field instead of below it
- Fix issue with backspacing making letter highlight go to last letter when word is empty

## 1.0.0

- Play wordle game
- Restart wordle game
- Share Result Emoji
