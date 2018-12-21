require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  let!(:group_event){ build(:group_event) }
  let!(:starts){ 1.day.ago.to_date }
  let!(:ends){ 1.day.from_now.to_date }

  it 'belongs to a user' do
    expect(group_event).to belong_to(:user).inverse_of(:group_events)
  end

  describe 'validations' do
    it 'validates the presence of the event name' do
      expect(group_event).to validate_presence_of(:name)
    end

    context 'when it is marked as a draft' do
      let!(:group_event){ build(:group_event, :draft) }

      it 'can be saved with the event name only' do
        expect(group_event).to be_valid
      end
    end

    context 'when it is marked as published' do
      let!(:group_event){ build(:group_event, :published) }

      it 'is valid when all fields are set' do
        expect(group_event).to be_valid
      end

      it 'validates the presence of the name' do
        expect(group_event).to validate_presence_of(:name)
      end

      it 'validates the presence of the start date' do
        expect(group_event).to validate_presence_of(:starts)
      end

      it 'validates the presence of the end date' do
        expect(group_event).to validate_presence_of(:ends)
      end

      it 'validates the presence of the description' do
        expect(group_event).to validate_presence_of(:description)
      end

      it 'validates the presence of the location' do
        expect(group_event).to validate_presence_of(:location)
      end
    end
  end

  describe '#days' do
    context 'when there are no start or end dates' do
      let!(:group_event){ build(:group_event, starts: nil, ends: nil) }

      it 'is 0' do
        expect(group_event.days).to be_zero
      end
    end

    context 'when there is only a start date' do
      let!(:group_event){ build(:group_event, starts: starts, ends: nil) }

      it 'is 0' do
        expect(group_event.days).to be_zero
      end
    end

    context 'when there is only an end date' do
      let!(:group_event){ build(:group_event, starts: nil, ends: ends) }

      it 'is 0' do
        expect(group_event.days).to be_zero
      end
    end

    context 'when the start and end dates are set' do

      context 'when the start date is before the end date' do
        let!(:group_event){ build(:group_event, starts: starts, ends: ends) }

        it 'is the number of days between dates' do
          expect(group_event.days).to eq (ends - starts).to_i
        end
      end

      context 'when the start date is on or after the end date' do
        let!(:group_event){ build(:group_event, starts: starts, ends: starts) }

        it 'is 0' do
          expect(group_event.days).to be_zero
        end
      end
    end
  end

  describe '#soft_delete!' do
    let!(:group_event){ create(:group_event) }

    it 'marks the persisted record as deleted' do
      group_event.soft_delete!
      expect(group_event).to be_soft_deleted
    end
  end

  describe '#draft?' do
    context 'when it is a draft' do
      let!(:group_event){ build(:group_event, :draft) }

      it 'true' do
        expect(group_event.draft?).to be_truthy
      end
    end

    context 'when it is published' do
      let!(:group_event){ build(:group_event, :published) }

      it 'true' do
        expect(group_event.draft?).to be_falsey
      end
    end
  end

  describe '.published' do
    let!(:published_group_event){ create(:group_event, :published) }
    let!(:group_event){ create(:group_event, :draft) }
    let!(:records){ described_class.published }

    it 'is a relation of published group events' do
      expect(records).to_not include group_event
      expect(records).to include published_group_event
    end
  end

  describe '.drafts' do
    let!(:published_group_event){ create(:group_event, :published) }
    let!(:group_event){ create(:group_event, :draft) }
    let!(:records){ described_class.drafts }

    it 'is a relation of drafts' do
      expect(records).to include group_event
      expect(records).to_not include published_group_event
    end
  end

  describe '.deleted' do
    let!(:group_event){ create(:group_event, :soft_deleted) }
    let!(:existing_group_event){ create(:group_event) }
    let!(:records){ described_class.deleted }

    it 'is a relation of soft deleted records' do
      expect(records).to_not include existing_group_event
      expect(records).to include group_event
    end
  end

  describe '.existing' do
    let!(:group_event){ create(:group_event, :soft_deleted) }
    let!(:existing_group_event){ create(:group_event) }
    let!(:records){ described_class.existing }

    it 'is a relation of non soft deleted records' do
      expect(records).to include existing_group_event
      expect(records).to_not include group_event
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
