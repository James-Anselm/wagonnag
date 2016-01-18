class StaticPagesController < ApplicationController
  def home
    if(logged_in?)
      @user = current_user
      render 'users/show'
    end
  end

  def about
  end
end
