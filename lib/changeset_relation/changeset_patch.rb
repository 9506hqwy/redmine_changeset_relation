# frozen_string_literal: true

module RedmineChangesetRelation
  module ChangesetPatch
    def scan_comment_for_issue_ids
      return if comments.blank?

      setting = project.changeset_relation_setting
      if setting && setting.custom_field_id.present?
        scan_comment_for_issue_ids_by(setting.custom_field_id)
      else
        super
      end
    end

    def scan_comment_for_issue_ids_by(custom_field_id)
      self.issues = Utils.extract_references(comments)
        .map{|(a, r)| find_custom_values_by_value(custom_field_id, r)}
        .flatten
        .map{|cv| find_referenced_issue_by_id(cv.customized_id)}
        .uniq
    end

    private

    def find_custom_values_by_value(custom_field_id, custom_value)
      CustomValue.where(customized_type: 'Issue',
                        custom_field_id: custom_field_id,
                        value: custom_value)
    end
  end
end

Changeset.prepend RedmineChangesetRelation::ChangesetPatch
