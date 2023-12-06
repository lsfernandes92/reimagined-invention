class AddressSerializer < ActiveModel::Serializer
  attributes :id, :city, :street

  belongs_to :contact do
    link(:related) { contact_url(object.contact.id) }
  end
end