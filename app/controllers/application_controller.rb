class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :authorize
   
  protected

  def authorize
    unless User.find_by(id: session[:user_id])
      unless User.count == 0
        redirect_to login_url, notice: "Please log in"
      else
        user = User.new(name: "dummy", password: "password",
                       password_confirmation: "password")
          if user.save
            user = User.find_by(name: "dummy")
            session[:user_id] = user.id
            redirect_to edit_user_path(user)
          end
       end
     end
  end
end
