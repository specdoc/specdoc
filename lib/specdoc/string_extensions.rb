unless ''.respond_to?(:indent)
  class String
    def indent(count, char = ' ')
      gsub(/([^\n]*)(\n|$)/) do |_match|
        last_iteration = (Regexp.last_match(1) == '' && Regexp.last_match(2) == '')
        line = ''
        line << (char * count) unless last_iteration
        line << Regexp.last_match(1)
        line << Regexp.last_match(2)
        line
      end
    end
  end
end
