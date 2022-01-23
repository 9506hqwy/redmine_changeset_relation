# frozen_string_literal: true

require File.expand_path('../../test_helper', __FILE__)

# custom_value:9 --> issue:7 --> project:1 --> setting:1
#        |                                        ^
#        +---------> custom_field:2 --------------+

class ChangesetRelationSettingTest < ActiveSupport::TestCase
  fixtures :custom_fields,
           :projects

  def test_create
    s = ChangesetRelationSetting.new
    s.project = projects(:projects_001)
    s.custom_field = custom_fields(:custom_fields_001)
    assert s.save
  end

  def test_create_without_custom_field
    s = ChangesetRelationSetting.new
    s.project = projects(:projects_001)
    s.custom_field = nil
    assert s.save
  end

  def test_create_without_project
    s = ChangesetRelationSetting.new
    s.project = nil
    s.custom_field = custom_fields(:custom_fields_001)
    assert !s.save
  end
end
