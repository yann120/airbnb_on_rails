module ReviewsHelper

    def user_has_reviewed(reservation)
        review = Review.find_by(user_id: user_id_to_review(reservation), reservation_id: reservation.id)
        review.present?
    end

    def review_stars(score)
        res = ""
        5.times { |i| res += score > i ? fa_icon('star') : fa_icon('star-o') }
        res.html_safe
    end

    private
        def user_id_to_review(reservation)
            reservation = Reservation.find(reservation.id)
            if current_user == reservation.user
                reservation.room.user_id
            else
                reservation.user_id
            end
        end
end
