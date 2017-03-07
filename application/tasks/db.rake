namespace :db do
  desc 'Prints current schema version'
  task :version do
    version = if SEQUEL_DB.tables.include?(:schema_migrations)
                SEQUEL_DB[:schema_migrations].order(:filename.desc).first[:filename]
              end || 0

    puts "Schema Version: #{version}"
  end

  desc 'Perform migration up to latest migration available'
  task :migrate do
      Sequel::Migrator.run(SEQUEL_DB, 'application/migrate')
    Rake::Task['db:version'].execute
  end

  desc 'Perform migration up to latest migration available'
  task :seed do
    require './db/seeds'
  end

  desc 'Perform rollback to specified target or full rollback as default'
  task :rollback, :target do |t, args|
    unless args[:target]
      migrations = SEQUEL_DB[:schema_migrations].order(:filename).all
      target = migrations[migrations.length - 2][:filename]
    end

    args.with_defaults(target: target)

    Sequel::Migrator.run(SEQUEL_DB, 'application/migrate', target: args[:target].to_i)
    Rake::Task['db:version'].execute
  end

  desc "Perform migration reset (full rollback and migration)"
  task :reset do
    Sequel::Migrator.run(SEQUEL_DB, "application/migrate", :target => 0)
    Sequel::Migrator.run(SEQUEL_DB, "application/migrate")
    Rake::Task['db:version'].execute
  end

  desc "Remove all database tables and re-run migrations"
  task :refresh do
    if ENV['RACK_ENV'] != 'test'
      puts 'Refresh only permitted in test environment.'
      exit false
    end

    SEQUEL_DB.tables.each do |t|
      SEQUEL_DB.drop_table t.to_sym
    end

    Rake::Task['db:migrate'].execute
  end

  desc 'Generate a timestamped, empty Sequel migration.'
  task :migration, :name do |_, args|
    if args[:name].nil?
      puts 'You must specify a migration name (e.g. rake generate:migration[create_events])!'
      exit false
    end

    content = "Sequel.migration do\n  change do\n\n  end\nend\n"
    timestamp = Time.now.to_i
    filename = File.join('application/migrate', "#{timestamp}_#{args[:name]}.rb")

    File.open(filename, 'w') do |f|
      f.puts content
    end

    puts "Created the migration #{filename}"
  end
end
