require 'socket'
require 'byebug'
require 'json'
require 'uri' 

class Route

  def initialize
    @server = TCPServer.new('localhost', 8080)
    
  end

  def call

    loop do
      @client = @server.accept
      request_line = @client.readline
      method_token, target, version_number = request_line.split
      url, params = target.split('?')
      pre, controller, action = url.split('/')
      action = 'index' if action.nil?
      body = if method_token == 'GET'
          get_body(params)
        elsif method_token == 'POST'
          get_header
        end
      body['ip_address'] = ip_address
      begin
        if (method_token == 'GET' && get_requests(controller).include?(action)) || (method_token == 'POST' && post_requests(controller).include?(action))
          @controller = eval("#{controller[0].capitalize}#{controller[1..-1]}Controller").send('new', body, params, action)
          result, status = @controller.send(action)
        else
          result = ""
          status = "402 ERROR"
        end
      rescue
        result = ""
        status = "404 ERROR"
      end

      @client.puts http_response(method_token, target, version_number, status)
      @client.puts result
      @client.close
    end
  end

  private

  def get_requests(controller)
    gets = [ 'new', 'index', 'show', 'edit' ]
    if controller == 'posts'
      gets << 'rate'
      gets << 'topn'
      gets << 'ips'
    end 
    gets
  end
  
  def post_requests(controller)
    post = [ 'create', 'update' ]
    post << 'login' if controller == 'users'
    post
  end
  
  def get_body(params)
    body = {}
    unless params.nil?
      paramstring = params.split(' ')[0]
      params = paramstring.split('&')
      params.each do |data|
        key, value = data.split("=")
        body[key] = value
      end
    end
    body
  end
  
  def get_header
    all_headers = {}
    while true
      line = @client.readline
      break if line == "\r\n"
      header_name, value = line.split(": ")
      all_headers[header_name] = value
    end
    JSON.parse(@client.read(all_headers['Content-Length'].to_i)).to_h
  end
  
  def http_response(method_token, target, version_number, status)
    response_message =  "✅ Received a #{method_token} request to #{target} with #{version_number}"
    content_type ="application/json"
    http_response = <<~MSG
    #{version_number} #{status}
    Content-Type: #{content_type}; charset=#{response_message.encoding.name}
    Connection: close
    Location: #{target}
    #{response_message}
    MSG
  end

  def ip_address
    @client.peeraddr[3]
  end
end