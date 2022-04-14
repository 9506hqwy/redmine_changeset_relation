# frozen_string_literal: true

basedir = File.expand_path('../lib', __FILE__)
libraries =
  [
    'redmine_changeset_relation/changeset_patch',
    'redmine_changeset_relation/custom_field_patch',
    'redmine_changeset_relation/custom_value_patch',
    'redmine_changeset_relation/project_patch',
    'redmine_changeset_relation/utils',
    'redmine_changeset_relation/view_listener',
  ]

libraries.each do |library|
  require_dependency File.expand_path(library, basedir)
end

Redmine::Plugin.register :redmine_changeset_relation do
  name 'Redmine Changeset Relation plugin'
  author '9506hqwy'
  description 'This is a changeget relation using custom field plugin for Redmine'
  version '0.3.0'
  url 'https://github.com/9506hqwy/redmine_changeset_relation'
  author_url 'https://github.com/9506hqwy'
end
