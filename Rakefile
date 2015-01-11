require 'bundler/setup'

namespace :style do
  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = ['--color --format progress']
end

namespace :travis do
  desc 'Run tests on Travis CI'
  task ci: ['style:chef', 'unit']
end
