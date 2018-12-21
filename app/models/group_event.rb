class GroupEvent < ApplicationRecord
  belongs_to :user, inverse_of: :group_events

  validates :name,
    presence: true
  validates :starts,
    timeliness: {type: :date, allow_nil: true}
  validates :ends,
    timeliness: {type: :date, after: :starts, allow_nil: true, if: :starts}

  with_options({if: :published?, presence: true}) do |published_group_event|
    published_group_event.validates :starts
    published_group_event.validates :ends
    published_group_event.validates :description
    published_group_event.validates :location
  end

  scope :existing,
    -> { where(soft_deleted: false) }
  scope :deleted,
    -> { where(soft_deleted: true) }
  scope :drafts,
    -> { where(published: false) }
  scope :published,
    -> { where(published: true) }


  alias_attribute :deleted, :soft_deleted


  def days
    if starts.is_a?(Date) && ends.is_a?(Date) && starts < ends
      (ends.to_date - starts.to_date).to_i
    else
      0
    end
  end

  def draft?
    !published?
  end

  def soft_delete!
    update(soft_deleted: true) if persisted?
    self
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
