## static_scaffold version 0.1

This bit of code is not functional yet.

## Description

Rails 2.3 family of code generators that produces easy to edit scaffolded code with attractive 
defaults.  Code generation is the only "magic".  Nothing magic after code generation.

## Installation

    cd ~
    mkdir -p .rails
    cd ~/.rails
    git clone git://github.com/jrhicks/static-scaffolds.git generators

## Usage (Roadmap)

    # Scaffold out some complimentary style sheets, helers, and javascripts
    ruby script/generate static_app

    # Introspect the database and create what this framework calls a gen-spec, then edit
    ruby script/generate static_gen_specs MyModel
    nano RAILS_ROOT/static_scaffold/MyModelGenSpec.rb

    # Scaffold the code
    ruby script/generate static_scaffold MyModel

## Author

Jeffrey Hicks
