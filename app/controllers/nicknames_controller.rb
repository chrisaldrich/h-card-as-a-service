class NicknamesController < ApplicationController
  def index
    @nicknames = Nickname.all.order("name ASC")
  end

  def show
    @people = Nickname.where(name: params[:nickname]).all.map{ |n| n.person }

    if @people.blank?
      redirect_to root_path
    else
      render "people/show"
    end
  end
end
