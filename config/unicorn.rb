port = (ENV['PORT'] || 3000).to_i
listen port, :tcp_nopush => false
