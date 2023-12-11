module V2
  class AddressesController < ApplicationController
    before_action :set_contact, only: %i[ show update create destroy ]
  
    # GET /contacts/:contact_id/address
    def show
      render json: @contact.address
    end
  
    # PATCH/PUT /contacts/:contact_id/address
    def update
      if @contact.address.update(address_params)
        render @contact.address, status: :ok, location: @contact
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # POST /contacts/:contact_id/address
    def create
      @contact.address = Address.new(address_params)
  
      if @contact.save
        render json: @contact.address, status: :created, location: contact_address_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /contacts/:contact_id/address
    def destroy
      @contact.address.destroy!
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:contact_id])
      end
  
      def address_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end