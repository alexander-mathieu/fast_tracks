# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    render locals: {
      facade: DashboardShowFacade.new(current_user)
    }
  end
end
