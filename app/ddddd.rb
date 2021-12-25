class Api::V1::MemosController < ApplicationController
  include Secured

  before_action :set_jwt_payload
  before_action :set_api_v1_memo, only: %i[ show update destroy ]

  # GET /api/v1/memos
  def index
    @api_v1_memos = Api::V1::Memo.where(created_by: @sub)

    render json: @api_v1_memos
  end

  # GET /api/v1/memos/1
  def show
    render json: @api_v1_memo
  end

  # POST /api/v1/memos
  def create
    @api_v1_memo = Api::V1::Memo.new(api_v1_memo_params)
    @api_v1_memo.created_by = @sub

    if @api_v1_memo.save
      render json: @api_v1_memo, status: :created, location: @api_v1_memo
    else
      render json: @api_v1_memo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/memos/1
  def update
    if @api_v1_memo.update(api_v1_memo_params)
      render json: @api_v1_memo
    else
      render json: @api_v1_memo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/memos/1
  def destroy
    @api_v1_memo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_memo
      @api_v1_memo = Api::V1::Memo.where(created_by: @sub).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_memo_params
      params.permit(:title, :memo, :created_by)
    end

    def set_jwt_payload
      @jwt_payload = JWT.decode(request.headers[:Authorization].split(' ')[1], nil, nil)
      @sub = @jwt_payload[0]['sub']
    end
end
