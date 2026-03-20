class PagesController < ApplicationController
  include CurrentCart

  before_action :set_cart

  def questions; end

  def news; end

  def contact; end
end
