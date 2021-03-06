class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
 

  def index
    @commentable = find_commentable
    @comments = @commentable.comments
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
      
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    
    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create

    @commentable = find_commentable
    @comment = @commentable.comments.create(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment.commentable_id, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @commentable = find_commentable
    @comment = Comment.find(params[:comment])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @commentable }
      format.json { head :no_content }
    end
  end

  private
  def find_commentable  
    params.each do |name, value|  
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)  
      end  
    end  
    nil  
  end
end
