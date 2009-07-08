# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{static-generators}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeffrey Hicks"]
  s.date = %q{2009-07-08}
  s.description = %q{Generate attractive interfaces that are easy to edit.}
  s.email = %q{jrhicks (at) gmail (dot) com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/static_generators.rb", "LICENSE", "README.md", "tasks/deployment.rake", "TODO"]
  s.files = ["CHANGELOG", "lib/static_generators.rb", "LICENSE", "rails_generators/static_app/static_app_generator.rb", "rails_generators/static_app/templates/application_helper.rb", "rails_generators/static_app/templates/blueprint/grid.png", "rails_generators/static_app/templates/blueprint/ie.css", "rails_generators/static_app/templates/blueprint/LICENSE", "rails_generators/static_app/templates/blueprint/print.css", "rails_generators/static_app/templates/blueprint/screen.css", "rails_generators/static_app/templates/header_bg.png", "rails_generators/static_app/templates/icons/cross.png", "rails_generators/static_app/templates/icons/doc.png", "rails_generators/static_app/templates/icons/email.png", "rails_generators/static_app/templates/icons/external.png", "rails_generators/static_app/templates/icons/feed.png", "rails_generators/static_app/templates/icons/key.png", "rails_generators/static_app/templates/icons/pdf.png", "rails_generators/static_app/templates/icons/tick.png", "rails_generators/static_app/templates/icons/visited.png", "rails_generators/static_app/templates/icons/xls.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_flat_0_aaaaaa_40x100.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_flat_55_fbec88_40x100.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_glass_75_d0e5f5_1x400.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_glass_85_dfeffc_1x400.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_glass_95_fef1ec_1x400.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_gloss-wave_55_5c9ccc_500x100.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_inset-hard_100_f5f8f9_1x100.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-bg_inset-hard_100_fcfdfd_1x100.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-icons_217bc0_256x240.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-icons_2e83ff_256x240.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-icons_469bdd_256x240.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-icons_6da8d5_256x240.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-icons_cd0a0a_256x240.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-icons_d8e7f3_256x240.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/images/ui-icons_f9bd01_256x240.png", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/css/redmond/jquery-ui-1.7.2.custom.css", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/index.html", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/js/jquery-1.3.2.min.js", "rails_generators/static_app/templates/jquery-ui-1.7.2.custom/js/jquery-ui-1.7.2.custom.min.js", "rails_generators/static_app/templates/jrails/jquery-ui.js", "rails_generators/static_app/templates/jrails/jquery.js", "rails_generators/static_app/templates/jrails/jrails.js", "rails_generators/static_app/templates/layout.html.erb", "rails_generators/static_app/templates/layout_helper.rb", "rails_generators/static_app/templates/navigation_bar_bg.gif", "rails_generators/static_app/templates/plugins/jrails/CHANGELOG", "rails_generators/static_app/templates/plugins/jrails/init.rb", "rails_generators/static_app/templates/plugins/jrails/install.rb", "rails_generators/static_app/templates/plugins/jrails/javascripts/jquery-ui.js", "rails_generators/static_app/templates/plugins/jrails/javascripts/jquery.js", "rails_generators/static_app/templates/plugins/jrails/javascripts/jrails.js", "rails_generators/static_app/templates/plugins/jrails/javascripts/sources/jrails.js", "rails_generators/static_app/templates/plugins/jrails/lib/jrails.rb", "rails_generators/static_app/templates/plugins/jrails/README", "rails_generators/static_app/templates/plugins/jrails/tasks/jrails.rake", "rails_generators/static_app/templates/sorttable/sorttable.js", "rails_generators/static_app/templates/standard_banner.html.erb", "rails_generators/static_app/templates/standard_footer.html.erb", "rails_generators/static_app/templates/standard_header.html.erb", "rails_generators/static_app/templates/standard_navigation.html.erb", "rails_generators/static_app/templates/static_style.css", "rails_generators/static_app/templates/uni-form/jquery.js", "rails_generators/static_app/templates/uni-form/uni-form-generic.css", "rails_generators/static_app/templates/uni-form/uni-form.css", "rails_generators/static_app/templates/uni-form/uni-form.jquery.js", "rails_generators/static_app/USAGE", "rails_generators/static_authorization/static_authorization_generator.rb", "rails_generators/static_authorization/templates/migration.rb", "rails_generators/static_authorization/USAGE", "rails_generators/static_gen_specs/static_gen_specs_generator.rb", "rails_generators/static_gen_specs/templates/generator_specs.rb", "rails_generators/static_gen_specs/templates/model_gen_specs.rb", "rails_generators/static_gen_specs/USAGE", "rails_generators/static_scaffold/static_scaffold_generator.rb", "rails_generators/static_scaffold/templates/controller.rb", "rails_generators/static_scaffold/templates/functional_test.rb", "rails_generators/static_scaffold/templates/helper.rb", "rails_generators/static_scaffold/templates/helper_test.rb", "rails_generators/static_scaffold/templates/layout.html.erb", "rails_generators/static_scaffold/templates/model.rb", "rails_generators/static_scaffold/templates/paperclip_tokens.rb", "rails_generators/static_scaffold/templates/view_edit.html.erb", "rails_generators/static_scaffold/templates/view_index.html.erb", "rails_generators/static_scaffold/templates/view_new.html.erb", "rails_generators/static_scaffold/templates/view_show.html.erb", "rails_generators/static_scaffold/USAGE", "Rakefile", "README.md", "tasks/deployment.rake", "TODO", "USAGE", "Manifest", "static-generators.gemspec"]
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
