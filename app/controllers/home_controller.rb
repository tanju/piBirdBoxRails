class HomeController < ApplicationController
  def index
  	@tuersensor = Tuersensor.last
  end
end
