# frozen_string_literal: true

require_dependency 'changeset_relation/changeset_patch'
require_dependency 'changeset_relation/custom_field_patch'
require_dependency 'changeset_relation/custom_value_patch'
require_dependency 'changeset_relation/project_patch'
require_dependency 'changeset_relation/utils'
require_dependency 'changeset_relation/view_listener'

Redmine::Plugin.register :redmine_changeset_relation do
  name 'Redmine Changeset Relation plugin'
  author '9506hqwy'
  description 'This is a changeget relation using custom field plugin for Redmine'
  version '0.1.0'
  url 'https://github.com/9506hqwy/redmine_changeset_relation'
  author_url 'https://github.com/9506hqwy'
end
