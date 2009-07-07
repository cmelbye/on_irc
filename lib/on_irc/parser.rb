module IRC
  module Parser  
    def self.parse(line)      
      prefix = ''
      command = ''
      params = []
      msg = StringScanner.new(line)
      
      if msg.peek(1) == ':'
        msg.pos += 1
        prefix = msg.scan /\S+/
        msg.skip /\s+/
      end
      
      command = msg.scan /\S+/
      
      until msg.eos?
        msg.skip /\s+/
        
        if msg.peek(1) == ':'
          msg.pos += 1
          params << msg.rest
          msg.terminate
        else
          params << msg.scan(/\S+/)
        end
      end
      
      [prefix, command, params]
    end
  end
end

