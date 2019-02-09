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
  
  def response_error(code, exception = nil, **options)
    result = {status: code, error: ApiStatus::CODES[code]}.merge(options)
    
    if exception && show_exceptions?
      result.merge!(
        message: exception.message,
        trace:   exception.backtrace[0..9]
      )
    end
    
    render json: result, status: :unprocessable_entity
  end
  
  def show_exceptions?
    ENV.fetch('SHOW_EXCEPTIONS', '0') > '0'
  end
end
