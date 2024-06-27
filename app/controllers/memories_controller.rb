class MemoriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @memory = current_user.memories.build(memory_params)
    if @memory.save
      flash[:success] = "Memory created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home', status: :unprocessable_entity
    end
  end

  def destroy
    @memory.destroy
    flash[:success] = "Memory deleted"
    if request.referrer.nil?
      redirect_to root_url, status: :see_other
    else
      redirect_to request.referrer, status: :see_other
    end
  end

  private

    def memory_params
      params.require(:memory).permit(:content)
    end

    def correct_user
      @memory = current_user.memories.find_by(id: params[:id])
      redirect_to root_url, status: :see_other if @memory.nil?
    end
end
