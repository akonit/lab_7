class FilmsController < ApplicationController

	http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

	def new
		@film = Film.new
	end

    def create
    	@film = Film.new(film_params)
 
        if @film.save
            redirect_to @film
	    else
	        render 'new'
	    end
    end

	def edit
	    @film = Film.find(params[:id])
	end

	def update
	    @film = Film.find(params[:id])
	 
	    if @film.update_attributes(film_params)
	        redirect_to @film
	    else
	        render 'edit'
	    end
	end

    def show
        @film = Film.find(params[:id])
    end

	def index
        @films = Film.all
    end

	def destroy
	  	@film = Film.find(params[:id])

        @film.session_ids.each { |fsid|
        	@session = Session.find(fsid)
        	@cinema = Cinema.find(@session.cinema_id.to_s)
    		new_session_ids = Array.new
    	    @cinema.session_ids.each { |csid| 
    		    if csid != fsid
    			    new_session_ids << csid
    		    end 
    		} 
    		@cinema.session_ids = new_session_ids
    	    @cinema.save
    	    @session.destroy
    	}
	  	@film.destroy
	 
	  	redirect_to films_path
	end

    private
	    def film_params
	        params.require(:film).permit(:name, :description)
	    end
end
