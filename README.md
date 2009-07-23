## Static Scaffolds

    Scaffold usable rails apps that are easy to edit.

## Install Gem

		gem install echoe
    git clone git://github.com/jrhicks/static-scaffolds.git
		cd static-scaffolds
		rake install

## Create Base Rails App

    rails project_name -m http://github.com/jrhicks/static-scaffolds/raw/master/rails_templates/static_base.rb

## Basic Usage

    ruby script/generate static_app
    ruby script/generate static_gen_specs MyModel
    ruby script/generate static_scaffold MyModel

## Basic Walkthrough

    rails address_book -m http://github.com/jrhicks/static-scaffolds/raw/master/rails_templates/static_base.rb
    ruby script/generate model contact full_name:string birth_date:datetime email:string phone:string city:string state:string
    rake db:migrate
    ruby script/generate static_gen_specs contact -f
    ruby script/generate static_scaffold contact -f
    rake db:populate_fake_contacts
    ruby script/server
    http://localhost:3000/contacts

## Author

    Jeffrey Hicks

