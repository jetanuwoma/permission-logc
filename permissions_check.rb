require_relative 'lib/hubspot_client'
require_relative 'permission_processor'

# Initialize the HubspotClient
client = HubspotClient.new

# Initialize PermissionsProcessor with the client
processor = PermissionsProcessor.new(client)

# Process permissions and post results
processor.process
