# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
    identifier :id

    view :me do
        fields :first_name, :last_name, :username, :email
    end

    view :normal do
        fields :username
    end

    view :profile do
        association :location, blueprint: LocationBlueprint
        association :posts, blueprint: PostBlueprint, view: :profile do |user, options|
            user.posts.order(created_at: :desc).limit(5)
        end
    
        association :events, blueprint: EventBlueprint, view: :profile do |user, options|
            user.events.order(start_date_time: :desc).limit(5)
        end
    end
end
