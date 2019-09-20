class ReviewsController < ApplicationController
    before_action :reservation_belongs_to_user, :review_dont_exist, only: [:create]
    def create
        @review = Review.create(review_params)
        redirect_back(fallback_location: request.referer, notice: "Review has been created")
    end

    def destroy
            @review = Review.find(params[:id])
            @review.destroy
            redirect_back(fallback_location: request.referer, notice: "Review has been deleted")
    end

    private

        def review_params
            parameters = params.require(:review).permit(:comment, :score, :reservation_id).merge(user_id: user_id_to_review)
        end

        def user_id_to_review
            reservation = Reservation.find(params.require(:review)[:reservation_id])
            if current_user == reservation.user
                reservation.room.user_id
            else
                reservation.user_id
            end
        end

        def review_dont_exist
            review = Review.find_by(user_id: user_id_to_review, reservation_id: review_params[:reservation_id])
            if review.present?
                redirect_back(fallback_location: request.referer, alert: "You already gave a review for this reservation")
            end
        end

        def reservation_belongs_to_user
            reservation = Reservation.find(review_params[:reservation_id])
            unless reservation.user == current_user || reservation.room.user == current_user
                redirect_back(fallback_location: request.referer, alert: "This reservation dont belongs to you")
            end
        end
end