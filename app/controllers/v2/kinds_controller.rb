module V2
  class KindsController < ApplicationController
    before_action :set_kind, only: %i[ show update destroy ]
  
    # GET /kinds
    # GET /kinds.json
    def index
      @kinds = Kind.all
      render json: @kinds
    end
  
    # GET /kinds/1
    # GET /kinds/1.json
    def show
      render json: @kind
    end
  
    # POST /kinds
    # POST /kinds.json
    def create
      @kind = Kind.new(kind_params)
  
      if @kind.save
        render :show, status: :created, location: @kind
      else
        render json: @kind.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /kinds/1
    # PATCH/PUT /kinds/1.json
    def update
      if @kind.update(kind_params)
        render :show, status: :ok, location: @kind
      else
        render json: @kind.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /kinds/1
    # DELETE /kinds/1.json
    def destroy
      @kind.destroy!
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_kind
        if params[:contact_id]
          @kind = Contact.find(params[:contact_id]).kind
          return @kind
        end
  
        @kind = Kind.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def kind_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end