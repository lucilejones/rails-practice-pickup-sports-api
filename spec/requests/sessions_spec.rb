require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    describe "POST /login" do

        let(:user) { create(:user) }

        it 'authenticates the user and returns a success response' do
            post '/login', params { username: user.username, password: user.password }
            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body)).to include('token')
        end
    end
end
