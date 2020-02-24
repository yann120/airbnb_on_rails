class PagesController < ApplicationController
  def home
    @rooms = Room.all.where(active: true)
  end

end
