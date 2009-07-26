desc "Build the manifest and gemspec files."
task :build => [:build_manifest, :build_gemspec]

task :deploy_all => [:manifest, :build, :install] do
  cd "/Users/jrhicks/src/samples"
  sh "rake static_force:all"
  cd "/Users/jrhicks/src/static-scaffolds"
end

task :deploy_gen_spec => [:manifest, :build, :install] do
  cd "/Users/jrhicks/src/samples"
  sh "ruby /Users/jrhicks/src/samples/rake static_force:gen_spec"
  cd "/Users/jrhicks/src/static-scaffolds"
end

task :deploy_scaffold => [:manifest, :build, :install] do
  cd "/Users/jrhicks/src/samples"
  sh "ruby /Users/jrhicks/src/samples/rake static_force:scaffold"
  cd "/Users/jrhicks/src/static-scaffolds"
end

task :deploy_app => [:manifest, :build, :install] do
  cd "/Users/jrhicks/src/samples"
  sh "ruby /Users/jrhicks/src/address_book/script/generate static_app -f -t"
  cd "/Users/jrhicks/src/static-scaffolds"
end