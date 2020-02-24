module PagesHelper
  def review_stars_with_room(room)
    score = Review.joins(:reservation).where(reservations: {room_id: room.id}).average(:score)
    return if score.nil?
    puts 'score', score
    res = ""
    5.times { |i| res += score > i ? fa_icon('star') : fa_icon('star-o') }
    res.html_safe
  end
end
