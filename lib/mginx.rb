class Mginx < MginxBehaviour
  attr_reader :app_servers

  def initialize(path, app_servers=[])
    @index = 0
    @app_servers = app_servers
    uri = URI(path)
    @server = TCPServer.new(uri.host, uri.port)
  end

  def add_server(s)
    @app_servers << s 
  end

  def remove_server(s)
    @app_servers.delete(s)
  end

  def run
    puts "Server runnig"
    loop do 
      Thread.new(@server.accept) do |client|
        request_details = client.recvmsg.first
        response = forward_request(request_details)
        client.puts HTTP::ResponseCreator.new(response).call
        client.close
      end.join
    end
  end

  def index 
    if @index >= @app_servers.length - 1 
      @index = 0 
    else 
      @index += 1
    end
  end

  def forward_request(request_details)
    return handle_requests if app_servers.length == 0
    app = nil
    while (app = app_servers[index]).busy? ; end
    app.serve_request(request_details)
  end
 
  #  handle requests here if app servers are empty
  def handle_requests 
     OpenStruct.new(body: "Welcome to Mginx")
  end
end