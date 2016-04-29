class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :invite]

  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)
    @room.users << User.find(room_params[:owner_id])

    if @room.save
      render json: @room.to_json(include: :users), status: :ok
    else
      render json: {error: @room.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # POST /rooms/invite
  # POST /rooms/invite.json
  def invite
    #Check that same user is not invited twice
    @room.users << User.find(params[:user_id])
    render json: @room.to_json(include: :users), status: :ok
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    if @room.update(room_params)
      render json: @room, status: :ok
    else
      render json: {error: @room.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Room was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:name, :socket_id, :owner_id)
    end
end
