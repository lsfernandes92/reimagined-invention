module V1
  class KindSerializer < ActiveModel::Serializer
    attributes :id, :description
  
    has_many :contacts
  end
end