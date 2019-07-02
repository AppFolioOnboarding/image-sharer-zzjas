require 'json'

module Api
  class FeedbacksController < ApplicationController
    def create
      req = JSON.parse(request.body.read)
      if req['userName'].present?
        render json: request.body.read
      else
        head :bad_request
      end
    end
  end
end
