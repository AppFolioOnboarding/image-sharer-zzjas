class ImagesController < ApplicationController
  def index
    @images = Image.order(created_at: :desc)
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      flash[:notice] = 'Image was successfully created.'
      redirect_to @image
    else
      flash[:notice] = 'Failed to create image.'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @image = Image.find_by(id: params[:id])
    return unless @image.nil?

    flash[:notice] = 'Failed to create image.'
    redirect_to new_image_path
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
