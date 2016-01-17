class StaticPagesController < ApplicationController
  def home
    if(logged_in?)
      @user = current_user
      render 'users/show'
    end
  end

  def help
  end

  def about
  end
end
