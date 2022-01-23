# frozen_string_literal: true

module RedmineChangesetRelationSetting
  class ViewListener < Redmine::Hook::ViewListener
    render_on :view_layouts_base_body_bottom, partial: 'changeset_relation_settings/body_bottom'
  end
end
