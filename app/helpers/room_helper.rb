module RoomHelper
    def is_done(fields = nil)
        return "<span class='icon is-right has-text-success'><i class='fa fa-check'></i></span>".html_safe if !fields
        fields.each do |field|
            return if field.blank?
        end
        "<span class='icon is-right has-text-success'><i class='fa fa-check'></i></span>".html_safe
    end

    def is_publishable(room)
        return !room.price.blank? && !room.listing_name.blank? && !room.summary.blank? && !room.room_pictures.blank? && !room.address.blank? 
    end
end
