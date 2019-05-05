class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by_credentials(params[:user][:username],
                                              [:user][:password])
        if user 
            login(user)
            redirect_to links_url
        else
            flash.now[:errors] = ["invalid credentials"]
            render :new 
        end
    end

    def destroy
        session[:session_token] = nil
        redirect_to new_session_url
    end


end