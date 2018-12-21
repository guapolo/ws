FactoryBot.define do
  factory :group_event do
    user
    sequence(:name) { |n| "Event #{n}" }
    starts { nil }
    ends { nil }
    description { nil }
    location { nil }
    published { false }
    soft_deleted { false }

    trait :draft do
      # same as above
    end

    trait :published do
      starts { 1.day.ago }
      ends { 2.days.from_now }
      description { "An event description" }
      location { "An address or venue name" }
      published { true }
    end

    trait :soft_deleted do
      soft_deleted { true }
    end
  end
end

# ## Schema Information
#
# Table name: `group_events`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `bigint(8)`        | `not null, primary key`
# **`description`**   | `text`             |
# **`ends`**          | `date`             |
# **`location`**      | `text`             |
# **`name`**          | `text`             |
# **`published`**     | `boolean`          | `default(FALSE), not null`
# **`soft_deleted`**  | `boolean`          | `default(FALSE), not null`
# **`starts`**        | `date`             |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`user_id`**       | `bigint(8)`        | `not null`
#
# ### Indexes
#
# * `index_group_events_on_name`:
#     * **`name`**
# * `index_group_events_on_user_id`:
#     * **`user_id`**
#
# ### Foreign Keys
#
# * `fk_rails_8cd5407a6e`:
#     * **`user_id => users.id`**
#
