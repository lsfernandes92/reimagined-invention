class Contact < ApplicationRecord
    belongs_to :kind, optional: true
    has_many :phones, dependent: :destroy
    has_one :address, dependent: :destroy

    accepts_nested_attributes_for :phones, allow_destroy: true
    accepts_nested_attributes_for :address, update_only: true
    
    def as_json(options)
      super(
        root: true,
        methods: :author,
        include: [:address, :kind, :phones]
      ) 
      # hash = super(options)
      # hash[:birthdate] = birthdate_br
      # hash
    end

    private 

    def birthdate_br
      I18n.l(self.birthdate) unless self.birthdate.blank?
    end

    def hello_world
      I18n.t('hello')
    end

    def author
      Faker::Name.name
    end
end
