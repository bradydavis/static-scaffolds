desc "Build the manifest and gemspec files."
task :build => [:build_manifest, :build_gemspec]

task :deploy_all => [:manifest, :build, :install] do
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_app -f -t"

  sh "ruby /Users/jrhicks/src/address_book/script/generate static_gen_specs department -f -t"
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_gen_specs employee -f -t"

  sh "ruby /Users/jrhicks/src/address_book/script/generate static_scaffold department -f -t"
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_scaffold employee -f -t"

end

task :deploy_gen_spec => [:manifest, :build, :install] do
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_gen_specs department -f -t"
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_gen_specs employee -f -t"
end

task :deploy_scaffold => [:manifest, :build, :install] do
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_scaffold department -f -t"
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_scaffold employee -f -t"
end

task :deploy_app => [:manifest, :build, :install] do
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_app -f -t"
end