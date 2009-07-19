## Static Scaffolds

    Scaffold usable rails apps that are easy to edit.

## Install Gem

    gem sources -a http://gems.github.com 
    gem install jrhicks-static-generators

## Install with Template

    rails project_name -m http://github.com/jrhicks/static-scaffolds/raw/master/rails_templates/static_base.rb

## Usage

    ruby script/generate static_app
    ruby script/generate static_gen_specs MyModel
    ruby script/generate static_scaffold MyModel

## Demo AddressBook App

    rails address_book -m http://github.com/jrhicks/static-scaffolds/raw/master/rails_templates/static_base.rb
    ruby script/generate model contact full_name, email, work_phone, cell_phone, street_address, city, state, zip
    rake db:migrate
    ruby script/generate static_gen_specs contact -f
    ruby script/generate static_scaffold contact -f
    rake db:populate_fake_contacts
    ruby script/server
    http://localhost:3000/contacts

## Development

    git clone git://github.com/jrhicks/static-scaffolds.git     

    gem install echoe
    rake manifest
    rake build
    rake install

## Author

    Jeffrey Hicks

