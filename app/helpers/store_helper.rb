module StoreHelper
  def counter
    unless session[:counter].nil? || session[:counter].blank?
      session[:counter]
    end
  end
end
