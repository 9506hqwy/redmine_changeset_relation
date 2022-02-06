# frozen_string_literal: true

class CreateChangesetRelationSettings < RedmineChangesetRelation::Utils::Migration
  def change
    create_table :changeset_relation_settings do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :custom_field, foreign_key: true
    end
  end
end
