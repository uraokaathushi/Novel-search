class Public::GenresSelectController < ApplicationController
  
  def genres_select
    @genres = Genre.all
  end
   
end
