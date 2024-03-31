## extend the db:migrate task to dump the schema after each migration

# pick the code from https://github.com/ctran/annotate_models/blob/develop/lib/tasks/annotate_models_migrate.rake
migration_tasks = %w[db:migrate db:migrate:up db:migrate:down db:migrate:reset db:migrate:redo db:rollback]

migration_tasks.each do |task|
  next if !Rake::Task.task_defined?(task) || Rails.application.config.active_record.dump_schema_after_migration

  Rake::Task[task].enhance do
    Rake::Task[Rake.application.top_level_tasks.last].enhance do
      puts 'Dumping schema...'
      system('SCHEMA_FORMAT=sql bin/rails db:schema:dump')
    end
  end
end
