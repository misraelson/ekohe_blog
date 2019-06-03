class PagesController < ApplicationController
  def home
    @blogs = Blog.all
    @page_title = "Amazing Articles"
  end
end
