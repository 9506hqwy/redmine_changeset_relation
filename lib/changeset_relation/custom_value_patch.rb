# frozen_string_literal: true

module RedmineChangesetRelationSetting
  module CustomValuePatch
    def self.prepended(base)
      base.class_eval do
        after_create :create_relation
        after_destroy :destroy_relation
        after_update :update_relation
      end
    end

    def changeset_relation_setting
      return nil if customized_type != 'Issue'

      setting = customized.project.changeset_relation_setting
      return nil if setting.blank?
      return nil if setting.custom_field_id != custom_field_id

      setting
    end

    private

    def create_relation
      return if value.blank?

      setting = changeset_relation_setting
      return if setting.blank?
      return if setting.custom_field_id.blank?

      create_relation_by_setting(setting)
    end

    def destroy_relation
      return if value.blank?

      setting = changeset_relation_setting
      return if setting.blank?
      return if setting.custom_field_id.blank?

      destroy_relation_by_setting
    end

    def update_relation
      if ActiveRecord::VERSION::MAJOR >= 5
        return unless saved_change_to_value?
      else
        return unless value_changed?
      end

      setting = changeset_relation_setting
      return if setting.blank?
      return if setting.custom_field_id.blank?

      if value.present?
        create_relation_by_setting(setting)
      else
        destroy_relation_by_setting
      end
    end

    def create_relation_by_setting(setting)
      id = value.to_i
      csets = Changeset.joins(repository: :project)
        .where(projects: {id: setting.project_id})
        .where('comments like ?', "%##{id}%")
        .select {|cset| Utils.extract_references(cset.comments).any? {|(a, r)| r == id}}
        .to_a
      customized.changesets = csets
    end

    def destroy_relation_by_setting
      customized.changesets = []
    end
  end
end

CustomValue.prepend RedmineChangesetRelationSetting::CustomValuePatch
