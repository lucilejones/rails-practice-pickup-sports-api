require 'rails_helper'

RSpec.describe Event, type: :model do
    context "validations" do
        it 'is not valid without a user' do
            event = build(:event, user:nil)
            expect(event).not_to be_valid
        end

        it 'is not valid without a title' do
            event = build(:event, title: nil)
            expect(event).not_to be_valid
        end

        it 'is not valid with start_date_time before current time' do
            event = build(:event, start_date_time: DateTime.now - 1)
            expect(event).not_to be_valid
        end

        it 'is not valid with start_date_time after end_date_time' do
            event = build(:event, start_date_time: DateTime.now + 1, end_date_time: DateTime.now)
            expect(event).not_to be_valid
        end
    end

    context "associations" do
        it 'belongs to a user' do
            event = build(:event)
            expect(event.user).to be_present
        end

        it 'has many comments' do
            event = create(:event)
            create_list(:comment, 3, commentable: event)

            event.reload
            expect(event.comments.count).to eq(3)
        end

        it 'has many sports' do
            event = create(:event)
            create_list(:sport, 3, events: [event])

            event.reload
            expect(event.sports.count).to eq(3)
        end
    end

    context "destroy related associations" do
      it 'destroys event participants' do
          event = create(:event)
          event_id = event.id
          event.destroy
          event_participants = EventParticipant.where(event_id: event.id)
          expect(event_participants).to be_empty
      end
    end
end
