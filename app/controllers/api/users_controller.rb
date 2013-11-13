class Api::UsersController < ApiController
  respond_to :json

  # GET /api/users.json
  def index
    @user = User.find_by(email: params[:email])

    if @user.present?
      respond_with @user, location: root_url, status: :ok
    else
      respond_with @user, location: root_url, status: :not_found
    end
  end

  # POST /api/users.json
  def create
    @user = User.new(user_params)
    @user.password = User::DEFAULT_PASSWORD

    if @user.save
      respond_with @user, location: root_url, status: :created
    else
      respond_with @user.errors, location: root_url, status: :unprocessable_entity
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:email)
    end
end
