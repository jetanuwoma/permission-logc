require_relative 'lib/hubspot_client'
require_relative 'permission_processor'

# Initialize the HubspotClient
client = HubspotClient.new

# Initialize PermissionsProcessor with the client
processor = PermissionsProcessor.new(client)

# Process permissions and get results
results = processor.process

# Post results back to the API
response = client.post_results(results)

# Output the response to verify success
puts response