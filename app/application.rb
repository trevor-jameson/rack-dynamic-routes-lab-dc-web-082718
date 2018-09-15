
class Application

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item_found = false
      Item.all.each do |item|
        if item_name == item.name
          resp.write "#{item.price}"
          item_found = true
          # The break assumes there can only be one match
          break
        end
      end
      if !item_found
        resp.status = 400
        resp.write "Item not found"
      end
    else
      resp.status = 404 # Unsure if this is the correct syntax
      resp.write "Route not found"
    end

    resp.finish
  end

  # End of Application class definition
end
