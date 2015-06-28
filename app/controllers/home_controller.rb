class HomeController < ApplicationController
  before_action :login_required, except: [:index]

  def index
  end
end
