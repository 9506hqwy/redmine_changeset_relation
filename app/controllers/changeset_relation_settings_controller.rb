# frozen_string_literal: true

class ChangesetRelationSettingsController < ApplicationController
  before_action :require_admin, :find_project_by_project_id

  def update
    setting = @project.changeset_relation_setting ||  ChangesetRelationSetting.new

    id = params[:changeset_relation_id]
    id = id.present? ? id.to_i : nil

    if id == setting.custom_field_id
      flash[:notice] = l(:notice_successful_update)
      redirect_to settings_project_path(@project, tab: :repositories)
    else
      setting.project_id = @project.id
      setting.custom_field_id = id

      if setting.save
        rescan = params[:changeset_relation_rescan]

        clear_and_rescan(rescan == 'true')

        flash[:notice] = l(:notice_successful_update)
        redirect_to settings_project_path(@project, tab: :repositories)
      else
        redirect_to settings_project_path(@project)
      end
    end
  end

  private

  def clear_and_rescan(scan)
    csets = Changeset.joins(repository: :project).where(projects: {id: @project.id})
    csets.each do |cset|
      cset.issues = []
      if scan
        cset.scan_comment_for_issue_ids
      end
    end
  end
end
