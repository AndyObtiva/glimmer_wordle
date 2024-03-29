# <img src='https://raw.githubusercontent.com/AndyObtiva/glimmer_wordle/master/icons/linux/Glimmer Wordle.png' height=85 /> Glimmer Wordle 1.1.6
## Play Wordle Endlessly with No Limit!
[![Gem Version](https://badge.fury.io/rb/glimmer_wordle.svg)](http://badge.fury.io/rb/glimmer_wordle)

[Wordle](https://en.wikipedia.org/wiki/Wordle) word game desktop GUI app written [test-first](https://github.com/AndyObtiva/wordle/blob/master/spec/app/model/five_letter_word_spec.rb) using [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) (JRuby Desktop Development GUI Framework) as inspiration by [Kevin Newton's blog post](https://kddnewton.com/2022/01/29/solving-wordle-in-ruby.html).

(Since the desktop version can leverage a real keyboard, there is no need to display the alphabets following the Qwerty layout, so they are displayed alphabetically to enable a more user-friendly experience, but the Qwerty layout is available as an [option](#options) if desired.)

Mac | Windows | Linux
----|---------|------
![Wordle Screenshot](screenshots/glimmer-wordle.png) | ![Wordle Screenshot Windows](screenshots/glimmer-wordle-windows.png) | ![Wordle Screenshot Linux](screenshots/glimmer-wordle-linux.png)

Other [Glimmer](https://github.com/AndyObtiva/glimmer) games:

[<img alt="Glimmer Tetris Icon" src="https://raw.githubusercontent.com/AndyObtiva/glimmer_tetris/master/package/linux/Glimmer%20Tetris.png" height=40 /> Glimmer Tetris](https://github.com/AndyObtiva/glimmer_tetris)

[<img alt="Glimmer Klondike Solitaire Icon" src="https://raw.githubusercontent.com/AndyObtiva/glimmer_klondike_solitaire/master/icons/linux/Glimmer%20Klondike%20Solitaire.png" height=40 /> Glimmer Klondike Solitaire](https://github.com/AndyObtiva/glimmer_klondike_solitaire)

## Demo

![Wordle Screenshot](screenshots/glimmer-wordle.gif)

## Setup

### Download

[<img src='https://raw.githubusercontent.com/AndyObtiva/glimmer_wordle/master/icons/linux/Glimmer Wordle.png' height=40 /> Download Glimmer Wordle 1.1.5 DMG for Mac x86_64 Ventura 13.4.1 and Older](https://www.dropbox.com/scl/fi/logokhlklr186m04lmj5u/Glimmer-Wordle-1.1.5-x86_64-ventura-13.4.1.dmg?rlkey=jlzah028gpy5h270yceeiy315&dl=1)

[<img src='https://raw.githubusercontent.com/AndyObtiva/glimmer_wordle/master/icons/linux/Glimmer Wordle.png' height=40 /> Download Glimmer Wordle 1.1.4 DMG for Mac ARM64 Ventura and Older](https://www.dropbox.com/s/diah745mycc8elz/Glimmer%20Wordle-1.1.4-arm64.dmg?dl=1)

[<img src='https://raw.githubusercontent.com/AndyObtiva/glimmer_wordle/master/icons/linux/Glimmer Wordle.png' height=40 /> Download Glimmer Wordle 1.1.2 DMG for Mac x86_64 Catalina and Older](https://www.dropbox.com/s/ysureb9o1dky7w0/Glimmer%20Wordle-1.1.2.dmg?dl=1)

[<img src='https://raw.githubusercontent.com/AndyObtiva/glimmer_wordle/master/icons/linux/Glimmer Wordle.png' height=40 /> Download Glimmer Wordle 1.1.3 DEB for Linux x86_64](https://www.dropbox.com/s/7jybodbf4pewhtd/glimmer-wordle_1.1.3-1_amd64.deb?dl=1)

[<img src='https://raw.githubusercontent.com/AndyObtiva/glimmer_wordle/master/icons/linux/Glimmer Wordle.png' height=40 /> Download Glimmer Wordle 1.1.3 RPM for Linux x86_64](https://www.dropbox.com/s/dfpjnquchxzl823/glimmer-wordle-1.1.3-1.x86_64.rpm?dl=1)

### Install Ruby Gem

If you are a software engineer and would rather install this game as a Ruby gem, please follow these instructions.

First, make sure you have all the [prerequisites of Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt#pre-requisites) setup on your machine like Java and JRuby.

Run:

```
gem install glimmer_wordle
```

Afterwards, run:

```
glimmer_wordle
```

## Options

The game menu bar has these View menu options:

1- **View -> Alphabet Layout -> Alphabetical**: Displays alphabets alphabetically

![Wordle Screenshot Alphabetical](screenshots/glimmer-wordle.png)

2- **View -> Alphabet Layout -> Qwerty**: Displays alphabets with the Qwerty keyboard layout

![Wordle Screenshot Qwerty](screenshots/glimmer-wordle-qwerty.png)

Also, the game supports Dark Mode, and will adopt a Dark Mode theme automatically if you start it with your System Settings having Dark Mode.

![Wordle Mac Dark Mode](screenshots/glimmer-wordle-mac-dark-mode.png)

## Process

[Glimmer Process](https://github.com/AndyObtiva/glimmer/blob/master/PROCESS.md)

## Contributing

-   Check out the latest master to make sure the feature hasn't been
    implemented or the bug hasn't been fixed yet.
-   Check out the issue tracker to make sure someone already hasn't
    requested it and/or contributed it.
-   Fork the project.
-   Start a feature/bugfix branch.
-   Commit and push until you are happy with your contribution.
-   Make sure to add tests for it. This is important so I don't break it
    in a future version unintentionally.
-   Please try not to mess with the Rakefile, version, or history. If
    you want to have your own version, or is otherwise necessary, that
    is fine, but please isolate to its own commit so I can cherry-pick
    around it.

## TODO

[TODO.md](TODO.md)

## Change Log

[CHANGELOG.md](CHANGELOG.md)

## Copyright

[MIT](LICENSE.txt)

Copyright (c) 2022-2023 Andy Maleh. See
[LICENSE.txt](LICENSE.txt) for further details.

--

[<img src="https://raw.githubusercontent.com/AndyObtiva/glimmer/master/images/glimmer-logo-hi-res.png" height=40 />](https://github.com/AndyObtiva/glimmer) Built with [Glimmer DSL for SWT](https://github.com/AndyObtiva/glimmer-dsl-swt) (JRuby Desktop Development GUI Framework)

Glimmer Wordle icon made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
