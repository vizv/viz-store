module Manage
  class ResourcesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bucket
    before_action :set_resource, only: [:show, :edit, :update, :destroy]

    # GET /resources
    # GET /resources.json
    def index
      @resources = Resource.all
    end

    # GET /resources/1
    # GET /resources/1.json
    def show
    end

    # GET /resources/new
    def new
      @resource = Resource.new
      @resource.bucket_id = params[:bucket_id]
    end

    # GET /resources/1/edit
    def edit
    end

    # POST /resources
    # POST /resources.json
    def create
      @resource = Resource.new(resource_params)
      @resource.bucket_id = params[:bucket_id]

      respond_to do |format|
        if @resource.save
          format.html { redirect_to [:manage, @resource.bucket, @resource], notice: '文件上传成功' }
          format.json { render :show, status: :created, location: @resource }
        else
          format.html { render :new }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /resources/1
    # PATCH/PUT /resources/1.json
    def update
      respond_to do |format|
        if @resource.update(resource_params)
          format.html { redirect_to [:manage, @bucket, @resource], notice: '文件更新成功' }
          format.json { render :show, status: :ok, location: @resource }
        else
          format.html { render :edit }
          format.json { render json: @resource.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /resources/1
    # DELETE /resources/1.json
    def destroy
      @resource.destroy
      respond_to do |format|
        format.html { redirect_to manage_bucket_path(@resource.bucket), notice: '文件删除成功' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_bucket
        @bucket = Bucket.find(params[:bucket_id])
      end

      def set_resource
        @resource = Resource.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def resource_params
        params[:resource].permit(:path, :file)
      end
  end
end