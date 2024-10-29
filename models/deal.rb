class Deal
  attr_reader :id, :owner_id

  def initialize(deal_struct)
    @id = deal_struct.dealId
    @owner_id = deal_struct.ownerUserId
  end
end

