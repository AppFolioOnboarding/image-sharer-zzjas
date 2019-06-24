class ImagesController < ApplicationController
  def index
    @images = images_with_tag.order(created_at: :desc)

    flash[:notice] = "No image with tag #{params[:tag]} found." if params[:tag].present? && @images.blank?
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

  def images_with_tag
    params[:tag].present? ? Image.tagged_with(params[:tag]) : Image.all
  end
end
