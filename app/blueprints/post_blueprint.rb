# frozen_string_literal: true

class PostBlueprint < Blueprinter::Base
    identifier :id

    view :profile do
        fields :content, :created_at
    end
end
