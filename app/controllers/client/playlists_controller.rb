class Client::PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  # GET /client/playlists or /client/playlists.json
  def index
    @playlists = current_user.playlists
  end

  # GET /client/playlists/1 or /client/playlists/1.json
  def show
    @playlist = current_user.playlists.find(params[:id])
    @songs = @playlist.songs
  end

  def add_song
    @playlist = current_user.playlists.find(params[:playlist_id])
    @song = Song.find(params[:song_id])
    if @playlist.songs << @song
      redirect_to song_path(@song), notice: 'Song added to playlist.'
    else
      redirect_to song_path(@song), alert: 'Failed to add song to playlist.'
    end
  end

  # GET /client/playlists/new
  def new
    @playlist = Playlist.new
    @playlist.playlist_songs.build
  end

  # GET /client/playlists/1/edit
  def edit
    @playlist = Playlist.find(params[:id])
  end

  # POST /client/playlists or /client/playlists.json
  def create
    @playlist = current_user.playlists.build(playlist_params)
    if @playlist.save
      redirect_to client_playlists_path, notice: 'Playlist was successfully created.'
    else
      redirect_to client_playlists_path, alert: 'Failed to create playlist.'
      render :index
    end
  end

  # PATCH/PUT /client/playlists/1 or /client/playlists/1.json
  def update
    @playlist = Playlist.find(params[:id])
  puts "Playlist: #{@playlist.inspect}" # Debugging
    respond_to do |format|
      if @playlist.update(playlist_params)
        format.html { redirect_to client_playlist_path(@playlist), notice: "Playlist was successfully updated." }
        format.json { render :show, status: :ok, location: @playlist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client/playlists/1 or /client/playlists/1.json
  def destroy
    @playlist.destroy!

    respond_to do |format|
      format.html { redirect_to client_playlist_path(@playlist), notice: "Playlist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_playlist
    @playlist = Playlist.find_by(id: params[:id])
    if @playlist.nil?
      redirect_to client_playlists_path, alert: "Playlist not found."
    end

  # Only allow a list of trusted parameters through.
    def playlist_params
      params.require(:playlist).permit(:name, :description)
    end
  end
end
