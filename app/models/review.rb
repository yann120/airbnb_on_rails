class Review < ApplicationRecord
    belongs_to :reservation

    def direction
        if self.reservation.room.user_id == self.user_id
            "host_review"
        else
            "guest_review"
        end
    end

    def from_user
       if self.reservation.room.user_id == self.user_id
            self.reservation.user
        else
            self.reservation.room.user
        end 
    end
end
