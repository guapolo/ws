class SerializableUser < JSONAPI::Serializable::Resource
  type 'user'

  attribute :username

  has_many :group_events do
    link :related do
      @url_helpers.user_group_events_url(@object.id, only_path: true)
    end

    meta do
      { count: @object.group_events.count }
    end
  end
end
