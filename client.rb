require 'socket'

class Client

  case ARGV[0]
    when '1'
      message = "HELO robin \n"
    when '2'
      message = "test\n"
    when '3'
      message = "KILL_SERVICE\n"
    else
      message = "hello server\n"
  end

  socket = TCPSocket.open 'localhost', 8000

  socket.puts message

  # Read the returned data
  while line = socket.gets
    puts line.chomp
  end

  socket.close
end