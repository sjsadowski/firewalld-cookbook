require 'bundler/setup'

namespace :style do
  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

namespace :travis do
  desc 'Run tests on Travis CI'
  task ci: ['style:chef']
end
