class DeserializableUser < JSONAPI::Deserializable::Resource
  type 'user'

  attribute :username
  has_many :group_events
end
