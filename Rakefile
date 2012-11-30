%w[bundler rake/testtask].each { |lib| require lib }

task :default => :spec

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
end

Rake::TestTask.new(:acceptance) do |t|
  t.libs << "spec"
  t.test_files = FileList['spec/**/*_acceptance.rb']
end

namespace :db do
  desc "Rebuild database (destructive migrations)"
  task :auto_migrate do
    require_relative "boot.rb"
    DataMapper.auto_migrate!
  end

  desc "Run database migrations (non-destructive)"
  task :auto_upgrade do
    require_relative "boot.rb"
    DataMapper.auto_upgrade!
  end

  desc "Populate the database with some sample data"
  task :populate do
    require_relative "db/populate.rb"
  end
end

namespace :bundle do
  desc "benchmark bundle loading time"
  task :benchmark do
    require_relative 'lib/benchmark_bundle'
  end
end
