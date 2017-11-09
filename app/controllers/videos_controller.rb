class VideosController < ApplicationController
  include SesionesHelper
  before_action :set_video, only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.where(estado: false)
    .paginate(:page => params[:page], :per_page => 50)
    .order(created_at: :asc)
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
  end

  # GET /videos/new
  def new
    @concursos = Concurso.all
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    respond_to do |format|
      if @video.save
        message="12;32;"+@video.video_source.filename
        @ironmq = IronMQ::Client.new(host: 'mq-aws-eu-west-1-1.iron.io',token:'1Buw2JPnHAaxLQsrmkPj',project_id: "5a040693ab3f4b0009da54c0")
        @queue = @ironmq.queue("smtsQueue")
        @queue.post(message)
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:nombre, :apellido, :email, :titulo, :descripcion, :video_source, :concurso_id) #, :ppath, :state
    end
end
