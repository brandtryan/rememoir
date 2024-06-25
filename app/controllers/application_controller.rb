class ApplicationController < ActionController::Base
  def hello
    render html: "hello, amigos!"
  end
end
