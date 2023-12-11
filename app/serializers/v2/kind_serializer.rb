module V2
  class KindSerializer < ActiveModel::Serializer
    attributes :id, :description
  
    has_many :contacts
  end
end