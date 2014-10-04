class CinemasController < ApplicationController

	http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

	def new
		@cinema = Cinema.new
	end

    def create
    	@cinema = Cinema.new(cinema_params)
 
        if @cinema.save
            redirect_to @cinema
	    else
	        render 'new'
	    end
    end

	def edit
	    @cinema = Cinema.find(params[:id])
	end

	def update
	    @cinema = Cinema.find(params[:id])
	 
	    if @cinema.update_attributes(cinema_params)
	        redirect_to @cinema
	    else
	        render 'edit'
	    end
	end

    def show
        @cinema = Cinema.find(params[:id])
    end

    def index
        @cinemas = Cinema.all
    end

	def destroy
	  	@cinema = Cinema.find(params[:id])

        @cinema.session_ids.each { |csid|
        	@session = Session.find(csid)
        	@film = Film.find(@session.film_id.to_s)
    		new_session_ids = Array.new
    	    @film.session_ids.each { |fsid| 
    		    if fsid != csid
    			    new_session_ids << fsid
    		    end 
    		} 
    		@film.session_ids = new_session_ids
    	    @film.save
    	    @session.destroy
    	}
	  	@cinema.destroy
	 
	  	redirect_to cinemas_path
	end

    private
	    def cinema_params
	        params.require(:cinema).permit(:name, :description, :address)
	    end
end
