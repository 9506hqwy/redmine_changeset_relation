# frozen_string_literal: true

require File.expand_path('../../test_helper', __FILE__)

# custom_value:9 --> issue:7 --> project:1 --> setting:1
#        |                                        ^
#        +---------> custom_field:2 --------------+

class CustomValueTest < ActiveSupport::TestCase
  fixtures :custom_fields,
           :custom_fields_projects,
           :custom_values,
           :issues,
           :projects,
           :changeset_relation_settings

  def test_changeset_relation_setting
    v = custom_values(:custom_values_009)
    assert_not_nil v.changeset_relation_setting
  end

  def test_changeset_update_nil
    v = custom_values(:custom_values_009)
    v.value = nil
    v.save!

    issue = Issue.find(v.customized_id)
    assert_empty issue.changesets
  end

  def test_changeset_update_1
    v = custom_values(:custom_values_009)
    v.value = 1
    v.save!

    issue = Issue.find(v.customized_id)
    assert_not_empty issue.changesets
  end
end
