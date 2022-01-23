# frozen_string_literal: true

require File.expand_path('../../test_helper', __FILE__)

# changeset:2 --> repository:1 -----+
#   #1, #3                          v
# custom_value:9 --> issue:7 --> project:1 --> setting:1
#        |                                        ^
#        +---------> custom_field:2 --------------+

class ChangesetTest < ActiveSupport::TestCase
  fixtures :changesets,
           :custom_fields,
           :custom_fields_projects,
           :custom_values,
           :issues,
           :projects,
           :repositories,
           :changeset_relation_settings

  def test_scan_commend_for_issue_ids_cv
    cv = custom_values(:custom_values_009)
    cv.value = 1
    cv.save!

    cset = changesets(:changesets_002)
    cset.scan_comment_for_issue_ids
    assert_equal 1, cset.issues.count
  end

  def test_scan_commend_for_issue_ids_std
    s = changeset_relation_settings(:changeset_relation_settings_001)
    s.destroy!

    cset = changesets(:changesets_002)
    cset.scan_comment_for_issue_ids
    assert_equal 2, cset.issues.count
  end
end
