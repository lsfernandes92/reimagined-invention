class Contact < ApplicationRecord
    belongs_to :kind, optional: true

    def as_json(options={})
      super(
        root: true,
        methods: :author,
        include: :kind
      )
    end

    private 

    def birthdate_br
      I18n.l(self.birthdate) unless self.birthdate.blank?
    end

    def hello_world
      I18n.t('hello')
    end

    def author
      "Jorge Luis Borges"
    end
end
