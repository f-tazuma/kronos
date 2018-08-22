module Api
  class WorkersController < ApplicationController
    protect_from_forgery with: :null_session

    def search
      service = WorkersService.new()
      @view_bug = service.search_workers(params)
      render json: @view_bug
    end

  end
end
