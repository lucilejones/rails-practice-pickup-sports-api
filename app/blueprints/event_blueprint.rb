# frozen_string_literal: true

class EventBlueprint < Blueprinter::Base
    identifier :id

    view :profile do
        fields :content, :start_date_time, :end_date_time, :guests, :title
    end
end
