class SessionsController < ApplicationController
  
    http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

	def new
		@session = Session.new
	end

    def create
    	@session = Session.new(session_params)
        @session.save

        @film = Film.find(@session.film_id)
        @cinema = Cinema.find(@session.cinema_id)

        @film.session_ids << @session.id.to_s
        @cinema.session_ids << @session.id.to_s
 
        if @film.save && @cinema.save
            redirect_to @session
	    else
	        render 'new'
	    end
    end

	def edit
	    @session = Session.find(params[:id])
        @cinema = Cinema.find(@session.cinema_id)
        @film = Film.find(@session.film_id)
	end

	def update
	    @session = Session.find(params[:id])
	 
	    if @session.update_attributes(session_params)
	        redirect_to @session
	    else
	        render 'edit'
	    end
	end

    def show
        @session = Session.find(params[:id])
        @cinema = Cinema.find(@session.cinema_id)
        @film = Film.find(@session.film_id)
    end

	def index
        @sessions = Session.all
    end

	def destroy
	  	@session = Session.find(params[:id])
	  	@session.destroy

        @cinema = Cinema.find(@session.cinema_id.to_s)
    	new_session_ids = Array.new
        @cinema.session_ids.each { |csid| 
    		if csid != @session.id.to_s
    			new_session_ids << csid
    		end 
        } 
    	@cinema.session_ids = new_session_ids
    	@cinema.save

        @film = Film.find(@session.film_id.to_s)
    	new_session_ids = Array.new
    	@film.session_ids.each { |fsid| 
    		if fsid != @session.id.to_s
    			new_session_ids << fpid
    		end 
    	} 
    	@film.session_ids = new_session_ids
    	@film.save
    	
	  	@session.destroy
	 
	  	redirect_to sessions_path
	end

    private
	    def session_params
	        params.require(:session).permit(:start, :end, :cinema_id, :film_id)
	    end
end
