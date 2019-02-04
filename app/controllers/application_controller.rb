class ApplicationController < ActionController::API
  before_action do
    unless params[:api_key] == ENV['API_KEY']
      response_error(100)
    end
  end
  
  protected
  
  def response_success(**options)
    result = {status: 200}
    render json: result.merge(options)
  end
  
  def response_error(code, **options)
    result = {status: code, error: ApiStatus::CODES[code]}
    render json: result.merge(options), status: :unprocessable_entity
  end
end
