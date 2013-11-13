class ApiController < ActionController::Base
  skip_before_filter :verify_authenticity_token, :only => [:create]
	around_filter :global_request_logging

	private
	def global_request_logging
		begin
			yield
		ensure
			header = response.header.inspect
			totem  = request.parameters[:totem_tid].inspect
			status = response.status.inspect
			logger.info "  ApiResponse by #{self.class} from [#{totem}]: (#{status}) #{header}"
		end
	end
end