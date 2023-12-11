module V2
  class ContactSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :birthdate
  
    belongs_to :kind, optional: true, dependent: :destroy do
      link(:related) { contact_kind_url(object.id) }
    end
  
    # has_many :phones, dependent: :destroy do
    #   link(:related) { contact_phones_url(object.id) }
    # end
  
    # has_one :address, dependent: :destroy do
    #   link(:related) { contact_address_url(object.id) }
    # end
  
    meta {{ author: Faker::Name.name }}
  
    def attributes(*args)
      h = super(*args)
      h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
      h
    end
  end
end