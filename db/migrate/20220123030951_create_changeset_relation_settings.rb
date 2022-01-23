# frozen_string_literal: true

if ActiveRecord::VERSION::MAJOR >= 5
  Migration = ActiveRecord::Migration[4.2]
else
  Migration = ActiveRecord::Migration
end

class CreateChangesetRelationSettings < Migration
  def change
    create_table :changeset_relation_settings do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :custom_field, foreign_key: true
    end
  end
end
