class ReservationsController < ApplicationController
    before_action :authenticate_user!

    private def is_valid_date(date_string)
        d, m, y = date_string.split '-'
        Date.valid_date? y.to_i, m.to_i, d.to_i
    end

    def create
        room = Room.find(params[:room_id])

    if current_user == room.user
            flash[:alert] = "You can not book your own room."
        elsif !is_valid_date(reservation_params[:start_date]) && !is_valid_date(reservation_params[:end_date])
            flash[:alert] = "Unvalid date. Please choose correct dates"
        elsif Date.parse(reservation_params[:start_date]) > Date.parse(reservation_params[:end_date])
            flash[:alert] = "You can't leave the room before you enter in! 🤔"
        elsif is_conflict(Date.parse(reservation_params[:start_date]), Date.parse(reservation_params[:end_date]), room)
            flash[:alert] = "The room is already booked by someone else for this dates!"
        else
            start_date = Date.parse(reservation_params[:start_date])
            end_date = Date.parse(reservation_params[:end_date])
            nights = (end_date - start_date).to_i

            @reservation = current_user.reservations.build(reservation_params)
            @reservation.room = room
            @reservation.price = room.price
            @reservation.total = (room.price * nights) * 1.1
            @reservation.save

            flash[:notice] = "Booked Successfully"
        end
        redirect_to room
    end

    def trips
        @trips = current_user.reservations.order(start_date: :asc)
    end

    def current_reservations
        @reservations = []
        current_user.rooms.each do |room|
            room.reservations.each do |reservation|
                @reservations << reservation
            end
        end
        @reservations = @reservations.sort_by {|reservation| reservation[:start_date]}
    end

    private
        def is_conflict(start_date, end_date, room)
            check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
            check.size > 0
        end
        def reservation_params
            params.require(:reservation).permit(:start_date, :end_date, :guests)
        end
end