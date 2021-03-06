module Manage
  class BucketsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_bucket, only: [:show, :edit, :update, :destroy]
    rescue_from Mongoid::Errors::DocumentNotFound, :with => :handle_not_found

    # GET /buckets
    # GET /buckets.json
    def index
      @buckets = Bucket.all
    end

    # GET /buckets/1
    # GET /buckets/1.json
    def show
    end

    # GET /buckets/new
    def new
      @bucket = Bucket.new
    end

    # GET /buckets/1/edit
    def edit
    end

    # POST /buckets
    # POST /buckets.json
    def create
      @bucket = Bucket.new(bucket_params)

      respond_to do |format|
        if @bucket.save
          format.html { redirect_to [:manage, @bucket], notice: '空间创建成功' }
          format.json { render :show, status: :created, location: @bucket }
        else
          format.html { render :new }
          format.json { render json: @bucket.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /buckets/1
    # PATCH/PUT /buckets/1.json
    def update
      respond_to do |format|
        if @bucket.update(bucket_params)
          format.html { redirect_to [:manage, @bucket], notice: '空间更新成功' }
          format.json { render :show, status: :ok, location: @bucket }
        else
          format.html { render :edit }
          format.json { render json: @bucket.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /buckets/1
    # DELETE /buckets/1.json
    def destroy
      @bucket.destroy
      respond_to do |format|
        format.html { redirect_to manage_buckets_path, notice: '空间删除成功' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_bucket
        @bucket = Bucket.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def bucket_params
        params[:bucket].permit(:name)
      end

      def handle_not_found e
        case e.klass
        when Bucket
          report :not_found, error: "未找到 ID 为 #{e.params.first} 的储存空间"
        end
      end
  end
end
