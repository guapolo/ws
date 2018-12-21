module ExceptionHandler
  extend ActiveSupport::Concern

  included do

    rescue_from ::StandardError do |e|
      render_exception(e, :internal_server_error)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      render_exception(e, :not_found)
    end

    rescue_from ::ActiveRecord::RecordInvalid do |e|
      render_exception(e, :unprocessable_entity)
    end


    private

    def render_exception(e, status)
      render json: error_json(e, status),
             status: status
    end

    def error_json(e, status)
      hsh = Rails.env.production? ? error_hash(status) : debug_error_hash(e,status)
      Oj.dump({errors: [hsh], jsonapi: JSONAPI::Rails.config.jsonapi_object}, mode: :rails)
    end

    def error_hash(status)
      {
        id:     SecureRandom.uuid,
        title:  'An error occurred',
        detail: 'Oopsie!',
        status: ::Rack::Utils::SYMBOL_TO_STATUS_CODE[status].to_s
      }
    end

    def debug_error_hash(e, status)
      {
        id:     SecureRandom.uuid,
        title:  e.class.name,
        detail: e.message,
        source: { pointer: e.backtrace },
        status: ::Rack::Utils::SYMBOL_TO_STATUS_CODE[status].to_s
      }
    end
  end
end