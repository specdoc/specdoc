require 'rails_helper'
# Just a plain old controller spec, not specdoc
RSpec.describe "Comment Requests", type: :request do
  describe "GET /comments" do
    it "loads the index" do
      get comments_path
      expect(response).to have_http_status(200)
    end
  end
end
