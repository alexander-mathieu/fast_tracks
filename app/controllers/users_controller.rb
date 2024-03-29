# frozen_string_literal: true

# controller for user actions and dashboard
class UsersController < ApplicationController
  def show
    render locals: {
      facade: DashboardShowFacade.new(current_user)
    }
  end
end
