class Api::PhotosController < ApiController
  respond_to :json

  # GET /api/photos.json
  # curl -X GET -F "original_filename=Brazil.gif" -F "parent_type=Event" -F "parent_id=1" -F "totem_tid=003" http://localhost:3000/api/photos.json -v
  def index
    # A versao atual nao suporta criacao de places
    params[:parent_type] = "Event"

    if Photo.find_by(parent_type: params[:parent_type], parent_id: params[:parent_id], original_filename: params[:original_filename]).present?
      return(head :ok)
    else
      return(head :not_found)
    end

  end

  # POST /api/photos.json
  # curl -X POST -F "photo=@/Library/Application Support/Apple/iChat Icons/Flags/Brazil.gif" -F "parent_type=Event" -F "parent_id=1" -F "totem_tid=003" http://localhost:3000/api/photos.json -v
  def create
    @photo = Photo.new(photo_params)

    # A versao atual nao suporta criacao de places
    @photo.parent_type = "Event"
    begin
      @photo.owner = @photo.parent.owner
    rescue
      return(head :not_found, {obs: 'event not found', event: params[:parent_id]})
    end

    if @photo.save
      respond_with @photo, location: root_url, status: :created
    else
      respond_with @photo.errors, location: root_url, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.permit(:photo, :parent_id, :parent_type, :user_id, :tag_list)
    end
end
