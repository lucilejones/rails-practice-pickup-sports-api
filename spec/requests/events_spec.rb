require 'rails_helper'

RSpec.describe "Events", type: :request do
    describe "GET /events" do
        it 'returns a response with all the events' do
            create(:event)
            get '/events'
            expect(response.body).to eq(Event.all.to_json)
        end
    end

    describe "GET /event" do
        let (:event) { create(:event) }

        it "returns a response with the specified event" do
            get "/events/#{event.id}"
            expect(response.body).to eq(event.to_json)
        end
    end

    describe "POST /events" do
        let(:user) { create(:user) }
        let(:sport) { create(:sport) }

        before do
            event_attributes = attributes_for(:event, user_id: user.id, sport_ids: [sport.id])
            post "/events", params: event_attributes
        end

        it 'creates a new event' do
            expect(Event.count).to eq(1)
        end

        it 'return successful response' do
            expect(response).to be_successful
        end
    end

    describe "PUT /events/:id" do
        let (:event) { create(:event) }

        before do
            put "/events/#{event.id}", params: {title: "New Title"}
        end

        it 'updates an event' do
            event.reload
            expect(event.title).to eq("New Title")
        end
    end

    describe "DELETE /events/:id" do
        let (:event) { create(:event) }

        before do
            delete "/events/#{event.id}"
        end

        it 'deletes an event' do
            expect(Event.count).to eq(0)
        end
    end
end
