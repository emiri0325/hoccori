class PostsController < ApplicationController
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'    
    end
  end  

  def destroy
    @post.destroy
    flash[:success] = '記事を削除しました。'
    redirect_back(fallback_location: root_path)    
  end
  
  private

  def post_params
    params.require(:post).permit(:content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end  
  
end
