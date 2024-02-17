class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save
      redirect_to admin_genres_path
    else
      render 'admin/genres'
    end
  end

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def destroy
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path_path
  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end

end

