# frozen_string_literal: true

class EventBlueprint < Blueprinter::Base
    identifier :id

    view :profile do
        fields :content, :start_date_time, :end_date_time, :guests, :title
    end

    view :short do
        fields :title, :start_date_time, :end_date_time, :guests, :sports
        association :creator, blueprint: UserBlueprint, view: :normal
    end

    view :long do
        fields :title, :start_date_time, :end_date_time, :guests, :sports, :content, :cover_image_url
        association :participants, blueprint: UserBlueprint, view: :normal
        association :creator, blueprint: UserBlueprint, view: :normal
        field :has_joined do |event, options|
            event.has_joined?(options[:current_user])
        end
    end
end
