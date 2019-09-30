module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.macos?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end

  # TODO: add FreeBSD

  def OS.which?
    if OS.windows?
      return :windows
    end
    if OS.macos?
      return :macos
    end
    return :linux
  end
end
