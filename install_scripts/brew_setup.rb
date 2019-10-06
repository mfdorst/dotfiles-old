if RUBY_VERSION == '1.8.7'
  def require_rel(this_file, required_file)
    require File.join(File.dirname(this_file), required_file)
  end
  require_rel __FILE__, 'user_ask'
else
  require_relative 'user_ask'
end

def brew_installed?
  `which brew &> /dev/null`
  $?.success?
end

def install_brew()
  unless brew_installed?
    unless user_ask :default_confirm, "Would you like to install homebrew?"
      puts "Homebrew was not installed."
      return
    end
    # Download and install homebrew
    `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
    puts 'Homebrew was installed.'.green
  else
    puts 'Homebrew is already installed.'.green
  end
  puts
  puts 'Run `brew bundle --global` to install default packages.'.yellow
end
