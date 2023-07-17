class RemoveOrphanMigrations < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL.squish
        DELETE FROM schema_migrations WHERE version IN ('20230714132137', '20230714132229')
    SQL
  end
end
