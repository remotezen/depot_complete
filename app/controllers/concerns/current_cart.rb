module CurrentCart
  extend ActiveSupport::Concern
  private
    def set_cart
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
    def counter
      if session[:counter] != false
        if session[:counter].nil?
          session[:counter] = 0
        else
          counter = session[:counter].to_i
          counter +=1
          session[:counter] = counter
        end
      end
    end
    def reset_counter
      session[:counter] = ""
    end
end
