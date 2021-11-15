require 'bundler/setup'
require 'stove/rake_task'
Stove::RakeTask.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = ['--color --format progress']
end

namespace :travis do
  desc 'Run tests on Travis CI'
  task ci: ['unit']
end
