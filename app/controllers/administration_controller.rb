class AdministrationController < ApplicationController
  before_action :restrict_anonymous_access

  # get /admin
  def index
  end
end
