class ContactsController < ApplicationController
  # How to add HTPP authentication
  # # Digest authentication:
  include ActionController::HttpAuthentication::Digest::ControllerMethods
  USERS = { "admin" => Digest::MD5.hexdigest(["admin", "Application", "admin"].join(":")) }
  before_action :authenticate

  before_action :set_contact, only: %i[ show update destroy ]

  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all
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
      render :show, status: :created, location: @contact
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  # PATCH/PUT /contacts/1.json
  def update
    if @contact.update(contact_params)
      render :show, status: :ok, location: @contact
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

    def authenticate
      authenticate_or_request_with_http_digest do |username|
        USERS[username]
      end
    end
end
