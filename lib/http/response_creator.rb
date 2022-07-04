module HTTP 
  class ResponseCreator 
    attr_reader :response
    def initialize(response)
      @response = response
      @body = ""
    end

    def add_status 
      "HTTP/#{response.http_version} #{response.code} #{response.message}\n"
    end

    def add_body 
      response.body
    end

    def add_headers 
      s=""
      response.each_capitalized.each do |k, v|
        next if k == "Transfer-Encoding"
        s += "#{k}: #{v}\n"
      end
      s
    end

    def call
      add_status+add_headers+add_body
    end
  end
end