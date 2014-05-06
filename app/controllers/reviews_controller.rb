class ReviewsController < ApplicationController

  before_action :load_review, only: [:show, :edit, :update]
  before_action :load_user
  before_action :load_performance, only: [:new, :create, :edit, :update]

  before_action :authenticate
  before_action :authorize, only: [:new, :create, :edit, :update]

  def index
  end

  def show
    @company = @review.performance.run.company
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)    
    @user.reviews << @review
    @performance.reviews << @review
    
    if @review.save
      flash.discard(:notice)
      redirect_to user_path @user
    else
      flash[:notice] = "All fields are required"
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    if @review.update(review_params)
      flash.discard(:notice)
      redirect_to "/users/#{@review.user.id}"
    else
      flash[:notice] = "All fields are required"
      render :edit
    end
  end


  private

    # TODO Need an authorize method here for update and destroy
    # to check if current_user == @review.user

    def load_review
      @review = Review.find(params[:id])
    end

    def load_user
      @user = current_user
    end

    def load_performance
      @performance = Performance.find(params[:performance_id])
    end

    def review_params
      params.require(:review).permit(:title, :review_text, :rating)
    end

end