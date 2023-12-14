require 'rails_helper'

RSpec.describe V1::ContactsController, type: :controller do
  before do
    request.headers['ACCEPT'] = 'application/vnd.api+json'
  end

  describe 'GET #index' do
    context 'when the request header ACCEPT is not valid' do
      before do
        request.headers['ACCEPT'] = 'application/xml'
        get :index
      end

      it 'returns status code 406' do
        expect(response).to have_http_status(406)
      end
    end

    context 'when the request header ACCEPT is valid' do
      it 'returns status code 200' do
        get :index

        expect(response).to have_http_status(200)
      end
    end

    describe 'GET #show' do
      let(:contact) { Contact.first }

      before { create_contact }

      it 'returns status code 200' do
        get :show, params: { id: contact.id }

        expect(response).to have_http_status(200)
      end

      it 'responds with the contact node' do
        get :show, params: { id: contact.id }

        expect(response_body['data']['id']).to eq(contact.id.to_s)
        expect(response_body['data']['type']).to eq('contacts')
        expect(response_body['data']['attributes']['name']).to eq(contact.name)
        expect(response_body['data']['attributes']['email']).to eq(contact.email)
        expect(response_body['data']['attributes']['birthdate'].to_date).to eq(contact.birthdate)
      end
    end
  end

  private

    def create_contact
      contact = Contact.new
      contact.name= 'John Doe'
      contact.email = 'jd@gmail.com'
      contact.birthdate = Time.now
      contact.save!
    end

    def response_body
      JSON.parse(response.body)
    end
end