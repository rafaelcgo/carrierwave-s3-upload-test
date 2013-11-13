class Api::EventsController < ApiController
	respond_to :json

  # GET /api/events.json
  # curl -X GET -F "email=user@test.com" http://localhost:3000/api/events.json -v
  def index
    @events = Event.includes(:owner)
    @events = @events.where("UPPER(events.name) LIKE UPPER(?)", "%#{params[:term]}%")
    @events = @events.where("users.email = '#{params[:email]}'").references(:owner) if params[:email].present?

    respond_with @events.to_json(include: [:owner])
  end

  # GET /api/events/1.json
  def show
    respond_with Event.find(params[:id]).to_json(include: [:owner])
  end

  # POST /api/events.json
  # curl -X POST -F "email=user@test.com" -F "totem_tid=1" -F "name=name" http://localhost:3000/api/events.json -v
  def create
    @event = Event.new(event_params)

    @event.owner = User.find_by(email: (params[:email] || User::DEFAULT_API_EMAIL))
    @event.name  = params[:name] || I18n.t('controllers.api.events.default_name', totem_tid: (params[:totem_tid] || 'X'))

    if @event.save
      respond_with @event, status: :created
    else
      respond_with @event, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.permit(:name, :starts_at, :ends_at, :place_id, :user_id)
    end
end
