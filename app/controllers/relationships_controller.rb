class RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id].to_i)
    redirect_to request.referer
  end

  def unfollow
    current_user.unfollow(params[:id].to_i)
    redirect_to request.referer
  end
end
