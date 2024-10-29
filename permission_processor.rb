require_relative 'lib/dataset_response'

class PermissionsProcessor
  def initialize(client)
    @client = client
  end

  def process
    data = DatasetResponse.new(@client.fetch_dataset)
    results = data.users.map do |user|
      {
        'userId' => user.id,
        'viewableDealIds' => viewable_deals(user, data.deals, data.users).uniq,
        'editableDealIds' => editable_deals(user, data.deals, data.users).uniq
      }
    end
    p results
    # @client.post_results(results)
  end

  private

  def viewable_deals(user, deals, users)
    return deals.map(&:id) if user.can_view_all?

    deals.select do |deal|
      user.id == deal.owner_id ||
        (user.owned_or_team_permission?(user.view_permission) && in_user_teams?(user, deal.owner_id, users))
    end.map(&:id)
  end

  def editable_deals(user, deals, users)
    return deals.map(&:id) if user.can_edit_all?

    deals.select do |deal|
      user.id == deal.owner_id ||
        (user.owned_or_team_permission?(user.edit_permission) && in_user_teams?(user, deal.owner_id, users))
    end.map(&:id)
  end

  def in_user_teams?(user, owner_id, users)
    owner = users.find { |u| u.id == owner_id }
    (user.team_ids & owner.team_ids).any? if owner
  end
end
