# frozen_string_literal: true

module RedmineChangesetRelation
  module ProjectPatch
    def self.prepended(base)
      base.class_eval do
        has_one :changeset_relation_setting, dependent: :destroy
      end
    end
  end
end

Project.prepend RedmineChangesetRelation::ProjectPatch
