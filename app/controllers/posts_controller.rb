class PostsController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:destroy]  
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page]).per(5)
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'    
    end
  end  

  def destroy
    @post.destroy
    flash[:success] = '記事を削除しました。'
    redirect_back(fallback_location: root_path)    
  end
  
  def edit
    @post = current_user.posts.find_by(id: params[:id])
    if @post
      render "posts/edit"
    else
      redirect_to root_url
    end  
  end

  def update
    @post = current_user.posts.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:success] = '更新しました。'
      redirect_to root_url
    else
      flash[:success] = '更新できませんでした。'
      redirect_back(fallback_location: root_path)   
    end  
  end
  
  private

  def post_params
    params.require(:post).permit(:content, :img)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end  
  
end
