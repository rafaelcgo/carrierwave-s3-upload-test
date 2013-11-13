class EventsController < ApplicationController
  load_and_authorize_resource except: [:show]
  skip_before_filter :authenticate_user!, only: [:show]

  # GET /events
  # GET /events.json
  def index
    @events = Event.includes(:owner).where("UPPER(name) LIKE UPPER(?)", "%#{params[:term]}%")
    @events = @events.where(owner: current_user)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find_by(permalink: params[:id])

    respond_to do |format|
      format.html
    end
  end

  # GET /events/new
  def new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.owner = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_path(@event.permalink), notice: I18n.t('flash.actions.create.notice', resource_name: Event.model_name.human) }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_path(@event.permalink), notice: I18n.t('flash.actions.update.notice', resource_name: Event.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :starts_at, :ends_at, :place_id, :user_id)
    end
end
