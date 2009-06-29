desc "Build the manifest and gemspec files."
task :build => [:build_manifest, :build_gemspec]

desc "Move gemspec to root for github"
task :publish_gem => :build do
   # it would be nice to bridge echoe's output to work with github
    
end