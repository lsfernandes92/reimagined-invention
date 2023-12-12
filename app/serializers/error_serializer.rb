module ErrorSerializer
  def self.serializer(errors)
    response = {}

    hash = errors.to_hash.map do |key, value|
      value.map do |message|
        { id: key, title: message }
      end
    end.flatten

    response[:errors] = hash
    response
  end
end