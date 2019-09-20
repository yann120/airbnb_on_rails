class Review < ApplicationRecord
    belongs_to :reservation

    def direction
        if self.reservation.room.user_id == self.user_id
            "host_review"
        else
            "guest_review"
        end
    end
end
