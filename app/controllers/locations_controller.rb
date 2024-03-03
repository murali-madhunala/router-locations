class LocationsController < ApplicationController
    include Waterfall

    def connections
      Flow.new
          .chain(response: :output) { GetConnectionsList.new(route_locations_url: ENV['ROUTE_LOCATIONS_URL']) }
          .halt_chain do |outflow, error_pool|
        if error_pool
          render json: { error: error_pool }, status: :internal_server_error
        else
          render json: outflow.response.data, status: :ok
        end
      end
    end
end