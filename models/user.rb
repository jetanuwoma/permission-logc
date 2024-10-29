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

  def owned_or_team_permission?(permission_type)
    permission_type == 'OWNED_OR_TEAM'
  end
end
