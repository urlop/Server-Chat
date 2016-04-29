class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages?user1=:user1&user2=:user2&room=:room
  def get_conversation
    if (params[:room])
      @messages = Message.where('receiver_room_id = ?', params[:room])    
    else
      @messages = Message.where('(sender_id = :user_id_1 OR sender_id = :user_id_2) AND (receiver_user_id = :user_id_1 OR receiver_user_id = :user_id_2)', user_id_1: params[:user1], user_id_2: params[:user2])
    end
    render json: @messages, status: :ok
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: {error: @message.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    if @message.update(message_params)
      render json: @message, status: :ok, location: @message
    else
      render json: {error: @message.errors.full_messages.first}, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender_id, :receiver_user_id, :receiver_room_id, :content)
    end
end
