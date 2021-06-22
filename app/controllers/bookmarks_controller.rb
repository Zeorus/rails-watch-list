class BookmarksController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.movie = @movie
    @bookmark.list = @list
    if @bookmark.save!
      redirect_to list_path(@list), notice: "\"#{@movie.title}\" a été ajouté avec succès."
    else
      redirect_to list_path(@list), notice: "Erreur lors de l'ajout de la vidéo."
    end
  end
  
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list), notice: "La vidéo a été retirée de la liste avec succès."
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end 
end
