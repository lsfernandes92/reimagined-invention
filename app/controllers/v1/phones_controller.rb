module V1
  class PhonesController < ApplicationController
    before_action :set_contact, only: %i[ show create update ]
    before_action :set_phone, only: %i[ update destroy ]
  
    # GET /contacts/:contact_id/phones
    def show
      render json: @contact.phones
    end
  
    # PATCH/PUT /contacts/:contact_id/phone
    def update
      if @phone.update!(phone_params)
        render json: @contact.phones, status: :ok, location: contact_phones_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # POST /contacts/:contact_id/phone
    def create
      @contact.phones << Phone.new(phone_params)
  
      if @contact.save
        render json: @contact.phones, status: :created, location: contact_phones_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /contacts/:contact_id/phone
    def destroy
      @phone.destroy!
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:contact_id])
      end
  
      def set_phone
        @phone = Phone.find(phone_params[:id])
      end
  
      def phone_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end