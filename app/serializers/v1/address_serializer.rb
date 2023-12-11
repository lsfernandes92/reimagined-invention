module V1
  class AddressSerializer < ActiveModel::Serializer
    attributes :id, :city, :street
  
    belongs_to :contact do
      link(:related) { v1_contact_url(object.contact.id) }
    end
  end
end