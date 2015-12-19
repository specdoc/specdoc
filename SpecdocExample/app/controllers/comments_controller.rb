class CommentsController < ActionController::Base
  def index
    render json: {foo: 'bar'}
  end

  def show
    render json: 'OK'
  end

  def create
    if params[:comment]
      render json: {ok: true}, status: 201
    else
      render json: {error: "Foo Bar Baz"}, status: 422
    end
  end
end
