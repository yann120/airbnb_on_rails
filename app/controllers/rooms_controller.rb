class RoomsController < ApplicationController
  before_action :set_room, except: [:index, :new, :create, :delete_image_attachment]
  before_action :authenticate_user!, except: [:show]
  def index
    @rooms = current_user.rooms
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to listing_room_path(@room), notice: "New room created successfully!"
    else
      render :new, notice: "Something didn't work..."
    end
  end

  def show

  end

  def update
    if @room.update(room_params)
      flash[:notice] = "Room updated successfully"
    else
      flash[:notice] = "Something didn't work..."
    end
    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end
  
  def preload
    today = Date.today
    reservations = @room.reservations.select("start_date, end_date").where("start_date >= ? OR end_date >= ?", today, today)

    render json: reservations
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
  end

  def delete_image_attachment
    image_to_delete = ActiveStorage::Attachment.find(params[:id])
    if image_to_delete.purge
      flash[:notice] = "Image successfully deleted"
    else
      flash[:notice] = "Something didn't work..."
    end
    redirect_back(fallback_location: request.referer)
  end

  def amenities
  end

  def location
  end

  private
    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:home_type, :room_type, :accommodate, :bed_room, :bath_room, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_air, :is_heating, :is_internet, :price, :active, :room_pictures)
    end
end
