# frozen_string_literal: true

module RedmineChangesetRelation
  module ChangesetPatch
    def scan_comment_for_issue_ids_or
      return if comments.blank?

      setting = project.changeset_relation_setting
      if setting && setting.custom_field_id.present?
        scan_comment_for_issue_ids_by(setting.custom_field_id)
      elsif block_given?
        yield
      end
    end

    def scan_comment_for_issue_ids_by(custom_field_id)
      self.issues = Utils.extract_references(comments)
        .map{|(a, r)| find_custom_values_by_value(custom_field_id, r)}
        .flatten
        .map{|cv| find_referenced_issue_by_id(cv.customized_id)}
        .compact
        .uniq
    end

    private

    def find_custom_values_by_value(custom_field_id, custom_value)
      CustomValue.where(customized_type: 'Issue',
                        custom_field_id: custom_field_id,
                        value: custom_value)
    end
  end

  module ChangesetPatch4
    include ChangesetPatch

    def self.included(base)
      base.class_eval do
        alias_method_chain(:scan_comment_for_issue_ids, :changeset_relation)
      end
    end

    def scan_comment_for_issue_ids_with_changeset_relation
      scan_comment_for_issue_ids_or do
        scan_comment_for_issue_ids_without_changeset_relation
      end
    end
  end

  module ChangesetPatch5
    include ChangesetPatch

    def scan_comment_for_issue_ids
      scan_comment_for_issue_ids_or do
        super
      end
    end
  end
end

if ActiveSupport::VERSION::MAJOR >= 5
  Changeset.prepend RedmineChangesetRelation::ChangesetPatch5
else
  Changeset.include RedmineChangesetRelation::ChangesetPatch4
end
