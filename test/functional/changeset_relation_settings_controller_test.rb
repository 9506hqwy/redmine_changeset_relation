# frozen_string_literal: true

require File.expand_path('../../test_helper', __FILE__)

# changeset:2 --> repository:1 -----+
#   #1, #3                          v
# custom_value:9 --> issue:7 --> project:1 --> setting:1
#        |                                        ^
#        +---------> custom_field:2 --------------+

class ChangesetRelationSettingsControllerTest < Redmine::ControllerTest
  include Redmine::I18n

  fixtures :changesets,
           :custom_fields,
           :custom_fields_projects,
           :custom_values,
           :enabled_modules,
           :issues,
           :member_roles,
           :members,
           :projects,
           :roles,
           :repositories,
           :users,
           :changeset_relation_settings

  def test_update
    @request.session[:user_id] = 1

    cv = custom_values(:custom_values_010)
    cv.value = 1
    cv.save!

    project = Project.find(1)
    put :update, params: {
      project_id: project.id,
      changeset_relation_id: '6',
      changeset_relation_rescan: 'false',
    }

    assert_redirected_to "/projects/#{project.identifier}/settings/repositories"
    assert_not_nil flash[:notice]
    assert_nil flash[:error]

    project.reload
    assert_not_nil project.changeset_relation_setting
    assert_equal 6,  project.changeset_relation_setting.custom_field.id

    cset = changesets(:changesets_002)
    assert_equal 0, cset.issues.count
  end

  def test_update_with_scan
    @request.session[:user_id] = 1

    cv = custom_values(:custom_values_010)
    cv.value = 1
    cv.save!

    project = Project.find(1)
    put :update, params: {
      project_id: project.id,
      changeset_relation_id: '6',
      changeset_relation_rescan: 'true',
    }

    assert_redirected_to "/projects/#{project.identifier}/settings/repositories"
    assert_not_nil flash[:notice]
    assert_nil flash[:error]

    project.reload
    assert_not_nil project.changeset_relation_setting
    assert_equal 6,  project.changeset_relation_setting.custom_field.id

    cset = changesets(:changesets_002)
    assert_equal 1, cset.issues.count
  end

  def test_update_nil
    @request.session[:user_id] = 1

    project = Project.find(1)
    put :update, params: {
      project_id: project.id,
      changeset_relation_id: '',
      changeset_relation_rescan: 'false',
    }

    assert_redirected_to "/projects/#{project.identifier}/settings/repositories"
    assert_not_nil flash[:notice]
    assert_nil flash[:error]

    project.reload
    assert_not_nil project.changeset_relation_setting
    assert_nil project.changeset_relation_setting.custom_field

    cset = changesets(:changesets_002)
    assert_equal 0, cset.issues.count
  end

  def test_update_nil_with_scan
    @request.session[:user_id] = 1

    project = Project.find(1)
    put :update, params: {
      project_id: project.id,
      changeset_relation_id: '',
      changeset_relation_rescan: 'true',
    }

    assert_redirected_to "/projects/#{project.identifier}/settings/repositories"
    assert_not_nil flash[:notice]
    assert_nil flash[:error]

    project.reload
    assert_not_nil project.changeset_relation_setting
    assert_nil project.changeset_relation_setting.custom_field

    cset = changesets(:changesets_002)
    assert_equal 2, cset.issues.count
  end

  def test_update_create
    @request.session[:user_id] = 1

    project = Project.find(2)
    put :update, params: {
      project_id: project.id,
      changeset_relation_id: '2',
      changeset_relation_rescan: 'false',
    }

    assert_redirected_to "/projects/#{project.identifier}/settings/repositories"
    assert_not_nil flash[:notice]
    assert_nil flash[:error]

    project.reload
    assert_not_nil project.changeset_relation_setting
    assert_equal 2, project.changeset_relation_setting.custom_field.id
  end

  def test_update_deny_permission
    @request.session[:user_id] = 3

    project = Project.find(1)
    put :update, params: {
      project_id: project.id,
      changeset_relation_id: '3',
      changeset_relation_rescan: 'false',
    }

    assert_response 403
  end
end
