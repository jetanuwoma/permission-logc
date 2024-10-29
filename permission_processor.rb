require_relative 'lib/dataset_response'

class PermissionsProcessor
  def initialize(client)
    @client = client
  end

  def process
    data = DatasetResponse.new(@client.fetch_dataset)

    deal_ownership = data.deals.each_with_object({}) { |deal, hash| hash[deal.id] = deal.owner_id }
    user_teams = data.users.each_with_object({}) { |user, hash| hash[user.id] = user.team_ids }

    results = data.users.map do |user|
      {
        'userId' => user.id,
        'viewableDealIds' => viewable_deals(user, data.deals, deal_ownership, user_teams).uniq,
        'editableDealIds' => editable_deals(user, data.deals, deal_ownership, user_teams).uniq
      }
    end

    p results
    @client.post_results(results)
  end

  private

  def viewable_deals(user, deals, deal_ownership, user_teams)
    if user.can_view_all?
      deals.map(&:id)
    elsif user.can_view_owned_or_team?
      team_ids = user_teams[user.id]
      deals.select do |deal|
        deal.owner_id == user.id || (team_ids & user_teams[deal_ownership[deal.id]]).any?
      end.map(&:id)
    elsif user.can_view_owned_only?
      deals.select { |deal| deal.owner_id == user.id }.map(&:id)
    else
      []
    end
  end

  def editable_deals(user, deals, deal_ownership, user_teams)
    if user.can_edit_all?
      deals.map(&:id)
    elsif user.can_edit_owned_or_team?
      team_ids = user_teams[user.id]
      deals.select do |deal|
        deal.owner_id == user.id || (team_ids & user_teams[deal_ownership[deal.id]]).any?
      end.map(&:id)
    elsif user.can_edit_owned_only?
      deals.select { |deal| deal.owner_id == user.id }.map(&:id)
    else
      []
    end
  end
end
