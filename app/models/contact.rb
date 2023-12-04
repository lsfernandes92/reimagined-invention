class Contact < ApplicationRecord
    def author
      "Jorge Luis Borges"
    end

    def as_json(options={})
      super(methods: :author, root: true)
    end
end
