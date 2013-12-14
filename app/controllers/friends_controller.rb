class FriendsController < ApplicationController

  def index
    @friends = Friend.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @friends.map(&:name)
  end
end