class DeserializableGroupEvent < JSONAPI::Deserializable::Resource
  type { |t| Hash[type: t] }

  has_one :user

  attributes :deleted,
             :description,
             :ends,
             :location,
             :name,
             :published,
             :starts
end
