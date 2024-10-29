require_relative '../models/user'
require_relative '../models/deal'

# DatasetResponse to hold parsed users and deals
class DatasetResponse
  UserStruct = Struct.new(:userId, :teamIds, :viewPermissionLevel, :editPermissionLevel)
  DealStruct = Struct.new(:dealId, :ownerUserId)

  def initialize(data)
    @users = data['users'].map { |user_data| User.new(UserStruct.new(*user_data.values)) }
    @deals = data['deals'].map { |deal_data| Deal.new(DealStruct.new(*deal_data.values)) }
  end

  attr_reader :users, :deals
end
