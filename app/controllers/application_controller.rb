class ApplicationController < ActionController::API


  protected

  def validate_and_modify_jsonapi_params
    # we search for the bare data hash and move it to the _jsonapi key
    # This looks like a flaw on the jsonapi-rails gem
    if !params.has_key?(:_jsonapi) && params.has_key?(:data)
      params.merge!({_jsonapi: { data: params.delete(:data) }})
    end
  end
end
