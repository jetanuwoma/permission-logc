# User class to encapsulate user permissions
class User
  attr_reader :id, :team_ids, :view_permission, :edit_permission

  def initialize(user_struct)
    @id = user_struct.userId
    @team_ids = user_struct.teamIds
    @view_permission = user_struct.viewPermissionLevel
    @edit_permission = user_struct.editPermissionLevel
  end

  def can_view_all?
    view_permission == 'ALL'
  end

  def can_edit_all?
    edit_permission == 'ALL'
  end

  def can_view_owned_or_team?
    view_permission == 'OWNED_OR_TEAM'
  end

  def can_edit_owned_or_team?
    edit_permission == 'OWNED_OR_TEAM'
  end

  def can_view_owned_only?
    view_permission == 'OWNED_ONLY'
  end

  def can_edit_owned_only?
    edit_permission == 'OWNED_ONLY'
  end
end
