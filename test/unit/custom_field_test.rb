# frozen_string_literal: true

require File.expand_path('../../test_helper', __FILE__)

class CustomFieldTest < ActiveSupport::TestCase
  fixtures :custom_fields,
           :projects,
           :changeset_relation_settings

  def test_destroy
    c = custom_fields(:custom_fields_001)
    assert_equal 0, c.changeset_relation_settings.length
    assert c.destroy
  end

  def test_destroy_related
    c = custom_fields(:custom_fields_002)
    assert_equal 1, c.changeset_relation_settings.length
    begin
      c.destroy
      assert false
    rescue ActiveRecord::DeleteRestrictionError
      assert true
    end

    c = custom_fields(:custom_fields_002)
    assert_not_nil c
  end
end
