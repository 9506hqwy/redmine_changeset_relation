# frozen_string_literal: true

require File.expand_path('../../test_helper', __FILE__)

class ProjectTest < ActiveSupport::TestCase
  fixtures :custom_fields,
           :projects,
           :changeset_relation_settings

  def test_destroy
    p = projects(:projects_001)
    assert_not_nil p.changeset_relation_setting
    p.destroy!

    begin
      changeset_relation_settings(:changeset_relation_settings_001)
      assert false
    rescue ActiveRecord::RecordNotFound
      assert true
    end
  end
end
