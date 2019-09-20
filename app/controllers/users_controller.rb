class UsersController <  ApplicationController
    def show
        @user = User.find(params[:id])
        @rooms = @user.rooms
        @reviews = Review.where(user_id: @user.id)
    end
end
