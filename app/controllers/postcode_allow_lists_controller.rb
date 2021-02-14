# frozen_string_literal: true

class PostcodeAllowListsController < ApplicationController
  before_action :ensure_postcode_allow_list, only: %i[ destroy]
  before_action :postcode_allow_list, only: %i[edit update destroy]

  def index
    @postcode_allow_lists = PostcodeAllowList.all
  end

  def new
    @postcode_allow_list = PostcodeAllowList.new
  end

  def create
    @postcode_allow_list = PostcodeAllowList.new(postcode_allow_lists_params)
    if @postcode_allow_list.save
      redirect_to postcode_allow_lists_path, notice: 'Post Code successfully created.'
    else

      render :new, notice: 'Could not create Post Code.'
    end
  end

  def edit; end

  def update
    if @postcode_allow_list.update(postcode_allow_lists_params)
      flash[:notice] = 'Postcode successfully updated.'
      redirect_to postcode_allow_lists_url
    else
      render :edit
    end
  end

  def destroy
    @postcode_allow_list.destroy
    redirect_to postcode_allow_lists_url
  end


  private

  def postcode_allow_lists_params
    params.require(:postcode_allow_list).permit(:id, :postcode)
  end

  def postcode_allow_list
    @postcode_allow_list = PostcodeAllowList.find params[:id]
  end

  def ensure_postcode_allow_list
    return if PostcodeAllowList.find_by id: params[:id]

    redirect_to postcode_allow_lists_url, notice: 'Could not find postcode entry'
  end
end
