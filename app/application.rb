class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      show_cart(resp)
    elsif req.path.match(/add/)
      user_item = req.params["item"]
      resp.write add_item_to_cart(user_item)
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def show_cart(resp)
    if @@cart != []
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    else
      resp.write "Your cart is empty"
    end
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def add_item_to_cart(user_item)
    if @@items.include?(user_item)
      @@cart << user_item
      return "added #{user_item}"
    else
      return "We don't have that item"
    end
  end
end
