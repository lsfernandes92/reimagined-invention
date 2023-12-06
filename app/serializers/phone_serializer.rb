class PhoneSerializer < ActiveModel::Serializer
  attributes :id, :number

  belongs_to :contact, optional: true do
    link(:related) { contact_url(object.contact.id) }
  end
end