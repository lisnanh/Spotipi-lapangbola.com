class Client::DashboardsController < ApplicationController
  before_action :authenticate_user!
 # GET /client/dashboards or /client/dashboards.json
   def index
      Rails.logger.debug("Current user: #{current_user.inspect}")
   end

   def search
    @current_user = current_user
    # Mendapatkan query dari parameter pencarian
    query = params[:query]

    # Melakukan pencarian pada berbagai model
    @artists = Artist.where('name LIKE ?', "%#{query}%")
    @albums = Album.where('title LIKE ?', "%#{query}%")
    @songs = Song.where('title LIKE ?', "%#{query}%")

  end
  end
