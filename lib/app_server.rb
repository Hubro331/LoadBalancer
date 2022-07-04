class AppServerHandler < AppServerHandlerBehaviour
  def initialize(path)
    @path = path
    @busy = false
  end

  def serve_request(request)
    @busy = true
    request_parser = HTTP::RequestParser.new(request)
    request_parser.parse
    url = @path + "/" + request_parser.path 
    http = HTTP::Request.new(url, request_parser.body, request_parser.method, request_parser.headers)
    response = http.call
    @busy = false
    response
  end

  def busy?
    @busy
  end 

  class << self 
    def intialize_servers paths
      paths.map do |p|
        new(p)
      end
    end
  end

end