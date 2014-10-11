require 'socket'
require 'thread'

class MultiThreadedServer

  def initialize(size, port_no)
    @port_no = port_no
    @size = size# max number of connected clients
    @jobs = Queue.new# clients to be handled by threads
    @pool = Array.new(@size) do# array of threads = to max clients we accept
      Thread.new do
        loop do#all threads keep looping until they can handle a client's interaction
          client = @jobs.pop # take a client off the queue and handle it
          loop{#keep looping handling the clients msgs
          while message = client.gets do
          case message
            when /\AHELO/ then
              _, remote_port, _, remote_ip = client.peeraddr
              client.puts "#{message}IP: #{remote_ip}\nPort: #{remote_port}\nStudent ID: 11534207\n"
            when /\AKILL_SERVICE\n\z/ then
              client.puts 'SERVER SHUTTING DOWN.\n'
              client.close
              self.shutdown
            else
              client.puts message.chomp.reverse!
          end
          end
          }
        end
      end
    end

    @server = TCPServer.new @port_no
    @running = true
    self.run#start tcp server and run multithreaded server
  end

  def schedule(client)
    @jobs << client
  end

  def shutdown#as soon as we get a kill service, stop everything
    puts "Server shutdown"
    @server.close
    Thread.list.each do |thread|
      thread.exit
    end
  end

  def run
    puts "Server startup on port #{@port_no} with max clients #{@size}"
    clients = 0
    while @running do
      client = @server.accept
      clients+=1
      if clients < @size
        schedule(client)
      else
        client.puts "Server overloaded. You session is about to be terminated. Goodbye. \n"
        client.close
      end
    end
  end
end


port = ARGV[0] == nil ? 8000 : ARGV[0]
max = ARGV[1] == nil ? 10 : ARGV[1]
MultiThreadedServer.new(max,port)