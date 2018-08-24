class DashboardController < ApplicationController
  def index
    @profile = Profile.new(current_user)
  end
end
