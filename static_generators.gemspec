# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{static_generators}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jeffrey Hicks"]
  s.date = %q{2009-06-28}
  s.description = %q{Generate attractive interfaces that are easy to edit.}
  s.email = %q{jrhicks@gmail.com}
  s.files = ["README", "USAGE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jrhicks/static-scaffolds}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Generate attractive interfaces that are easy to edit.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 2.3"])
    else
      s.add_dependency(%q<rails>, [">= 2.3"])
    end
  else
    s.add_dependency(%q<rails>, [">= 2.3"])
  end
end
