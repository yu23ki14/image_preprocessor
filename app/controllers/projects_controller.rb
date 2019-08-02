class ProjectsController < ApplicationController
  require 'zip'
  require 'mini_magick'
  
  before_action :set_project, only: [:show, :cropper]
  
  def show
    @files = []
    dir_name = './app/assets/images/' + @project.images_path + '/*'
    files = Dir.glob(dir_name)
    files.each do |file|
      file = file.gsub("./app/assets/images/", "")
      @files.push(file)
    end
  end
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: 'プロジェクトを追加しました。'
    else
      redirect_to root_path, alert: 'プロジェクト名とプロジェクトIDを入力してください。'
    end
  end
  
  def destroy
    @project.destroy
    redirect_to root_path, notice: '削除しました。'
  end
  
  def cropper
    @files = []
    dir_name = './app/assets/images/' + @project.images_path + '/*'
    files = Dir.glob(dir_name)
    files.each do |file|
      file = helpers.asset_url(file.gsub("./app/assets/images/", ""))
      @files.push(file)
    end
    gon.files = @files
    gon.root_path_name = @project.images_path
  end
  
  def preprocess
    order_num = params[:order_num].to_i
    x = params[:x]
    y = params[:y]
    w = params[:w]
    h = params[:w]
    
    dir_name = './app/assets/images/' + params[:path_name] + '/*'
    files = Dir.glob(dir_name)
    file = files[order_num]
    if (x.to_i + y.to_i + w.to_i) > 0
      MiniMagick::Tool::Convert.new do |convert|
        convert << file
        convert.format('png').crop("#{w}x#{h}+#{x}+#{y}").extent("#{w}x#{h}").resize("512x512")
        convert << "./app/assets/images/#{params[:path_name]}_cropped/#{SecureRandom.uuid}.png"
      end
    else
      MiniMagick::Tool::Convert.new do |convert|
        convert << file
        convert.format('png').extent("#{w}x#{h}").resize("512x512")
        convert << "./app/assets/images/#{params[:path_name]}_cropped/#{SecureRandom.uuid}.png"
      end
    end
    render json: {result: "success"}
  end
  
  private
    def project_params
      params.require(:project).permit(:name, :summary, :images_path)
    end
    
    def set_project
      @project = Project.find(params[:id])
    end
    
end
