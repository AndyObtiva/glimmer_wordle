# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: glimmer_wordle 1.1.4 ruby vendor lib app

Gem::Specification.new do |s|
  s.name = "glimmer_wordle".freeze
  s.version = "1.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["vendor".freeze, "lib".freeze, "app".freeze]
  s.authors = ["Andy Maleh".freeze]
  s.date = "2023-01-24"
  s.description = "Glimmer Wordle - Word Game Desktop GUI App Written in Glimmer DSL for SWT (requires JRuby) - Play Wordle Endlessly with No Limit!".freeze
  s.email = "andy.am@gmail.com".freeze
  s.executables = ["glimmer_wordle".freeze]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "LICENSE.txt",
    "VERSION",
    "app/wordle.rb",
    "app/wordle/launch.rb",
    "app/wordle/model/five_letter_word.rb",
    "app/wordle/view/app_view.rb",
    "bin/glimmer_wordle",
    "config/warble.rb",
    "config/wordle-allowed-guesses.txt",
    "config/wordle-answers-alphabetical.txt",
    "icons/linux/Glimmer Wordle.png",
    "icons/macosx/Glimmer Wordle.icns",
    "icons/windows/Glimmer Wordle.ico",
    "vendor/jars/org/yaml/snakeyaml/1.28/snakeyaml-1.28.jar"
  ]
  s.homepage = "http://github.com/AndyObtiva/glimmer_wordle".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = ["You may run glimmer_wordle to start the game!".freeze]
  s.rubygems_version = "3.2.29".freeze
  s.summary = "Glimmer Wordle - Word Game Desktop GUI App".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.26.0.1"])
    s.add_runtime_dependency(%q<clipboard>.freeze, ["~> 1.3.6"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_development_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_development_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  else
    s.add_dependency(%q<glimmer-dsl-swt>.freeze, ["~> 4.26.0.1"])
    s.add_dependency(%q<clipboard>.freeze, ["~> 1.3.6"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
    s.add_dependency(%q<juwelier>.freeze, ["= 2.4.9"])
    s.add_dependency(%q<warbler>.freeze, ["= 2.0.5"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
  end
end

