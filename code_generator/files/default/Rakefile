require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen/rake_tasks'

namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: %w(style:chef style:ruby)

desc 'Run Test Kitchen integration tests'
Kitchen::RakeTasks.new

task default: %w(style kitchen:all)

namespace :travis do
  desc 'Run tests on Travis'
  task ci: %w(style)
end
