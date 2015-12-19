require 'rails_helper'
require 'specdoc'

# Specdoc example

RSpec.specdoc_request "Comment Requests" do
  describe 'comments [/v1/arenas]' do
    describe 'create a comment [POST]' do
      it 'responds with the created comment', as: 'succeed' do
        comment_params = {comment: "Hello World"}

        post comments_path(comment_params)

        expect(response.status).to eq(201)
      end

      it 'responds with the created comment', as: 'with errors' do
        comment_params = {foo: "bar"}

        post comments_path(comment_params)

        expect(response.status).to eq(422)
      end
    end
  end
end
