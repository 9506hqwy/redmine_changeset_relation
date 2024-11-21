# frozen_string_literal: true

class ChangesetRelationSetting < RedmineChangesetRelation::Utils::ModelBase
  belongs_to :project
  belongs_to :custom_field

  validates :project, presence: true
end
