class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind, optional: true, dependent: :destroy do
    link(:related) { kind_url(object.kind.id) }
  end
  
  has_many :phones, dependent: :destroy
  has_one :address, dependent: :destroy

  meta {{ author: Faker::Name.name }}

  def attributes(*args)
    h = super(*args)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
