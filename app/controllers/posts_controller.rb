class PostsController < ApplicationController
    before_action :set_post, only: [:update, :destroy]

    def create
      post = Post.new(post_params)
  
      if post.save
          render json: post, status: :created
      else
          render json: post.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @post.update(user_params)
          render json: @post, status: :ok
      else
          render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      if @post.destroy
          render json: nil, status: :ok
      else
          render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_post
      @post = User.find(params[:id])
    end
  
    def post_params
      params.permit(:content, :user_id)
    end
  end
