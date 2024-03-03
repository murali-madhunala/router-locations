class GetConnectionsList
  include Waterfall

  def initialize(route_locations_url:)
    @route_locations_url = route_locations_url
  end
  
  def call
    chain(routes_locations_data: :output) { RoutesLocationsClient.new(url: @route_locations_url, method: :get) }
    chain { |outflow| @routes_locations_data = outflow.routes_locations_data }
    chain { @connections_list = search_connections(data: @routes_locations_data) }
    chain(:output) { construct_response(@connections_list) }
  end

  private

  def search_connections(data:)
    locations_id_name_map = generate_location_id_name_map(data['locations'])
    router_location_map = {}
    connected_locations = []
    data['routers'].each do |router|
        router_location_map[router['id']] = router['location_id']
    end

    visited_connected_locations = {}
    data['routers'].each do |router|
        router_location_id = router['location_id']
        router['router_links'].each do |link_router_id|
            link_router_location_id = router_location_map[link_router_id]
            # If both location ids are same ignore the link.
            next if router_location_id == link_router_location_id

            key_combination = "#{router_location_id}-#{link_router_location_id}"
            reverse_key_combination = "#{link_router_location_id}-#{router_location_id}"
            
            # Checking if the location combination has already occurred
            next if visited_connected_locations.key?(key_combination) || visited_connected_locations.key?(reverse_key_combination)

            connected_locations.append("#{locations_id_name_map[router_location_id]} <-> #{locations_id_name_map[link_router_location_id]}")
            visited_connected_locations[key_combination] = true
        end
    end

    connected_locations
  end

  def generate_location_id_name_map(locations)
    locations_id_name_map = {}
    locations.each do |location|
        locations_id_name_map[location['id']] = location['name']
    end
    locations_id_name_map
  end

  def construct_response(connections_list)
    output = {
      success?: true,
      data: {
        connections: connections_list
      }
    }
    OpenStruct.new(output)
  end
end