class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  before_action :find_group_and_check_permission, only: [:new, :create]
  before_action :find_post_and_check_permission, only: [:edit, :destroy, :update]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to account_posts_path, notice: "Update Success"
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:alert] = "Post deleted"
      redirect_to account_posts_path
    else
      flash[:alert] = "Some errors occured! don't be deleted"
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_group_and_check_permission
    if !current_user.is_member_of?(Group.find(params[:group_id]))
      redirect_to root_path, alert: "You have no permission."
    end
  end

  def find_post_and_check_permission
    @post = Post.find(params[:id])
    @group = Group.find(params[:group_id])

    if !current_user.is_writer_of?(@post)
      redirect_to root_path, alert: "You can't modify this post that owned elses"
    end
  end
end
