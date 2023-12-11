module V1
  class ContactsController < ApplicationController
    before_action :authenticate_user!
  
    before_action :set_contact, only: %i[ show update destroy ]
  
    # GET /contacts
    # GET /contacts.json
    def index
      @contacts = Contact.first
      render json: @contacts
    end
  
    # GET /contacts/1
    # GET /contacts/1.json
    def show
      render json: @contact, include: [:kind, :phones, :address]
    end
  
    # POST /contacts
    # POST /contacts.json
    def create
      @contact = Contact.new(contact_params)
  
      if @contact.save
        render json: @contact, status: :created, location: v1_contact_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /contacts/1
    # PATCH/PUT /contacts/1.json
    def update
      if @contact.update(contact_params)
        render json: @contact, status: :ok, location: v1_contact_url(@contact)
      else
        render json: @contact.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /contacts/1
    # DELETE /contacts/1.json
    def destroy
      @contact.destroy!
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_contact
        @contact = Contact.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def contact_params
        ActiveModelSerializers::Deserialization.jsonapi_parse(params)
      end
  end
end