def user_ask(default, prompt)
  if default != :default_confirm and default != :default_deny
    raise ArgumentError.new("Argument must be either :default_confirm or :default_deny")
  end
  case default
  when :default_confirm
    if $accept_defaults
      true
    else
      print "#{prompt} [Y | n] "
      response = gets.chomp.downcase

      not response =~ /n|no/
    end
  when :default_deny
    if $accept_defaults
      false
    else
      puts "#{prompt} [y | N] "
      response = gets.chomp.downcase

      not response =~ /y|yes/
    end
  end
end
