class SearchController < ApplicationController
  def by_film
  end

  def by_film_result
	  if params[:search] && params[:search] != nil && params[:search] != ""
          @films = Film.where(name: /#{params[:search]}/).all
          if @films != nil && @films.size > 0
      	      @film = @films.first
	          @sessions = Session.where(film_id: /#{@film.id}/).all
	      else
	      	  redirect_to search_by_film_path
	      end
	  else
	      redirect_to search_by_film_path
	  end
  end

  def by_session
  end

  def by_session_result
	  if params[:from] && params[:from] != nil && params[:from] != "" && params[:to] && params[:to] != nil && params[:to] != ""
	  	  @from = Time.new(params[:from]).utc
          @to = Time.new(params[:to]).utc

  	      @sessions = Session.where(:start => { :$gte => @from})
  	          .where(:end => { :$lt => @to})
	  else
	      redirect_to search_by_session_path
	  end
  end

  def by_cinema
  end

  def by_cinema_result
	  if params[:search] && params[:search] != nil && params[:search] != ""
          @cinemas = Cinema.where(name: /#{params[:search]}/).all
          if @cinemas != nil && @cinemas.size > 0
      	      @cinema = @cinemas.first
	          @sessions = Session.where(cinema_id: /#{@cinema.id}/).all
	      else
	      	  redirect_to search_by_cinema_path
	      end
	  else
	      redirect_to search_by_cinema_path
	  end
  end
end