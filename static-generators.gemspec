# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{static-generators}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeffrey Hicks"]
  s.date = %q{2009-06-28}
  s.description = %q{Generate attractive interfaces that are easy to edit.}
  s.email = %q{jrhicks (at) gmail (dot) com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/static_generators.rb", "LICENSE", "README.md", "tasks/deployment.rake", "TODO"]
  s.files = ["CHANGELOG", "lib/static_generators.rb", "LICENSE", "rails_generators/static_app/static_app_generator.rb", "rails_generators/static_app/templates/application_helper.rb", "rails_generators/static_app/templates/layout.html.erb", "rails_generators/static_app/templates/layout_helper.rb", "rails_generators/static_app/templates/sorttable.js", "rails_generators/static_app/templates/static_style.css", "rails_generators/static_app/USAGE", "rails_generators/static_gen_specs/static_gen_specs_generator.rb", "rails_generators/static_gen_specs/templates/generator_specs.rb", "rails_generators/static_gen_specs/templates/model_gen_specs.rb", "rails_generators/static_gen_specs/USAGE", "rails_generators/static_scaffold/static_scaffold_generator.rb", "rails_generators/static_scaffold/templates/controller.rb", "rails_generators/static_scaffold/templates/functional_test.rb", "rails_generators/static_scaffold/templates/helper.rb", "rails_generators/static_scaffold/templates/helper_test.rb", "rails_generators/static_scaffold/templates/layout.html.erb", "rails_generators/static_scaffold/templates/model.rb", "rails_generators/static_scaffold/templates/view_edit.html.erb", "rails_generators/static_scaffold/templates/view_index.html.erb", "rails_generators/static_scaffold/templates/view_new.html.erb", "rails_generators/static_scaffold/templates/view_show.html.erb", "rails_generators/static_scaffold/USAGE", "Rakefile", "README.md", "static-generators.gemspec", "tasks/deployment.rake", "TODO", "USAGE", "Manifest"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jrhicks/static-scaffolds}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Static-generators", "--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{staticgenerators}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Generate attractive interfaces that are easy to edit.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
