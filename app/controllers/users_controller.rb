class UsersController < ApplicationController
  #If specific exception handling: http://code.tutsplus.com/articles/writing-robust-web-applications-the-lost-art-of-exception-handling--net-36395
  before_action :set_user, only: [:show, :edit, :update, :destroy, :show_friends, :show_rooms, :get_user_info]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/get_user_info
  def get_user_info
    @users = User.friends(@user) #where.not(id: @user)
    render json: {me: @user, users: @users, rooms: @user.rooms.as_json(include: :users)}, status: :ok
  end

  # GET /users/1/show_friends
  def show_friends
    render json: User.friends_by_name(@user.name), status: :ok
  end

  # GET /users/1/show_rooms
  def show_rooms
    render json: @user.rooms, status: :ok
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users/login
  # POST /users/login.json
  def login
    p '~~~login~~~'
    @user = User.find_by(name: user_params[:name])

    if @user
      @users = User.friends_by_name(user_params[:name])
      render json: {me: @user, users: @users, rooms: @user.rooms}, status: :ok
    else
      render json: {error: "User does not exist"}, status: :unprocessable_entity
    end
  end

  # POST /users #sign_up
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      @users = User.friends_by_name(user_params[:name])
      render json: {me: @user, users: @users, rooms: []}, status: :ok
    else
      render json: {error: @user.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 #connect
  # PATCH/PUT /users/1.json
  def update
    p '~~~update~~~'
    p user_params

    if @user.update(user_params)
      render json: @user.to_json(include: :rooms), status: :ok
    else
      render json: {error: @user.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :socket_id)
    end
end
