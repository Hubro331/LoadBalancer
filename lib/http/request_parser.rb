module HTTP
  class RequestParser
    attr_reader :headers, :method, :path, :body, :request

    def initialize(request)
      @request = request
      @headers = {}
      @method = nil 
      @path = "" 
    end
  
    def parse 
      top, @body = request.split("\r\n\r\n", 2) 
      request_header_details = top.split("\r\n")
      request_line = request_header_details.shift
      header_lines = request_header_details
      @method, @path, _p = request_line.split(" ")
      parse_headers(header_lines)
      parse_method(method)
    end

    private

    def parse_headers(header_lines)
      header_lines.each do |header|
        key, value = header.split(": ")
        @headers[key] = value
      end
    end

    def parse_method(method)
      @method = HTTP::Methods::ALL.include?(method) ? method : HTTP::Methods::GET 
    end

    def parse_body; end

  end
end