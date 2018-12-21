class SerializableGroupEvent < JSONAPI::Serializable::Resource
  type 'group_event'

  has_one :user do
    data do
      @object.user
    end

    link :related do
      @url_helpers.user_url(@object.user.id, only_path: true)
    end
  end

  attributes :deleted,
             :description,
             :ends,
             :location,
             :name,
             :published,
             :starts

  attribute :days do
    @object.days
  end
end
