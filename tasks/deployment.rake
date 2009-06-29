desc "Build the manifest and gemspec files."
task :build => [:build_manifest, :build_gemspec]

desc "Move gemspec to root for github"
task :publish => :build_gemspec  do
   sh "git add static-generators.gemspec"
   sh 'git commit -m "publish gem"'
   sh 'git push'
end