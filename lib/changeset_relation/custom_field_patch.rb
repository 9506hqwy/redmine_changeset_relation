# frozen_string_literal: true

module RedmineChangesetRelationSetting
  module CustomFieldPatch
    def self.prepended(base)
      base.class_eval do
        has_many :changeset_relation_settings, dependent: :restrict_with_exception
      end
    end
  end
end

CustomField.prepend RedmineChangesetRelationSetting::CustomFieldPatch
