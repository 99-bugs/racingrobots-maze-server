require "rake/testtask"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
  t.warning = false
end
desc "Run tests"

task default: :test
