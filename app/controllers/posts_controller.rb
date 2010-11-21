class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    
    if @post.save
      redirect_to posts_path, :notice => "Your post was created successfully."
    else
      render :action => :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    
    @post.update_attributes(params[:post])
    redirect_to post_path(@post), :notice => 'Your post was updated successfully.'
  end
  
  def destroy
  end

end
