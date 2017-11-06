class VideosController < ApplicationController
  include SesionesHelper
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.where(estado: false)
    #.paginate(:page => params[:page], :per_page => 50)
    #.order(created_at: :asc)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
  end

  def destroy
    @video.delete
    flash[:success] = "Video Eliminado!"
    redirect_to request.referrer || root_url
  end

  # GET /videos/new
  def new
    @concursos = Concurso.all
    #@video = Video.new
  end

  # GET /videos/1/edit
  def edit
    @concursos = Concurso.all
    @video = Video.find(params[:id])
  end

  def update
    puts "actualizar video"
    @video = Video.find(params[:id])
    @concurso = Concurso.find(video_params[:id])
    @video.concurso = @concurso
    if @video.update_attributes(:nombre => video_params[:nombre], :apellido => video_params[:apellido], :email => video_params[:email], :titulo => video_params[:titulo], :descripcion => video_params[:descripcion])
      flash[:success] = "Video Actualizado"
      redirect_to @video
      # Handle a successful update.
    else
      render 'edit'
    end

  end

  # POST /videos
  # POST /videos.json
def create
    puts "params - create"
    puts params
    @video = Concurso.new
    puts "done - create"
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:nombre, :apellido, :email, :titulo, :descripcion, :video_source, :id)
    end
end
