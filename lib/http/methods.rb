module HTTP
  module Methods
    GET = "GET".freeze
    PUT = 'PUT'.freeze
    DELETE = 'DELETE'.freeze 
    POST = 'POST'.freeze 
    PATCH = 'PATCH'.freeze
    ALL = [GET, PUT, DELETE, POST, PATCH].freeze
  end
end