module HTTP
  class Request
    attr_reader :url, :http_method, :body, :request, :headers

    def initialize(url, body, method, headers={})
      @url = URI(url)
      @http = Net::HTTP.new(@url.host, @url.port);
      @http_method = method 
      @body = body
      @headers = headers
    end

    def build_request
      @request = case http_method 
      when HTTP::Methods::GET 
        Net::HTTP::Get.new(url)
      when HTTP::Methods::POST
        Net::HTTP::Post.new(url)
      when HTTP::Methods::PUT 
        Net::HTTP::Put.new(url)
      when HTTP::Methods::DELETE
        Net::HTTP::Delete.new(url)
      when HTTP::Methods::PATCH 
        Net::HTTP::Patch.new(url)
      end
    end

    def add_headers
      headers.each do |k,v|
        @request[k] = v 
      end 
    end
    
    def add_body 
      @request.body = body
    end

    def call 
      build_request
      add_headers 
      add_body
      @http.request(request)
    end  
  end
end