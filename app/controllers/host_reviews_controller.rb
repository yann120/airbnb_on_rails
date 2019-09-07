class HostReviewsController < ApplicationController

    def create

        @reservation =  Reservation.where(
                            id: host_review_params[:reservation_id],
                            roomid: host_review_params[:room_id],
                            user_id: host_review_params[:user__id]
                        ).first
                        
        if !@reservation.nil?
            @has_reviewed = HostReview.where(
                reservation_id: @reservation.id,
                guest_id: host_review_params[:guest_id]
            ).first
            
            if @has_reviewed.nil?
                #allow review
                @host_review = current_user.host_reviews.create(host_review_params)
                flash[:success] = "Review created"
            else
                flash[:danger] = "You already gave a review for this reservation"
            end
        else
            flash[:alert] = "Reservation not found"
        end

        @host_review = current_user.host_reviews.create(host_review_params)
        redirect_back(fallback_location: request.referer)
    end

    def destroy
        @host_review = Review.find(params[:id])
        @host_review.destroy

        redirect_back(fallback_location: request.referer, notice: "Review has been deleted")
    end

    private
    def host_review_params
        params.require(:host_review).permit(:comment, :star, :room_id, :reservation_id, :guest_id)
    end
end