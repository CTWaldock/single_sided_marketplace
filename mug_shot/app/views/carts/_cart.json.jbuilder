json.extract! cart, :id, :has_many, :has_many, :qty, :price, :created_at, :updated_at
json.url cart_url(cart, format: :json)
