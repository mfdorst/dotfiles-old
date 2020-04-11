require "#{File.dirname __FILE__}/backup"
require "#{File.dirname __FILE__}/user_ask"

def symlink(source_dir, file, dest_dir=nil)
  src_path = File.join HOME, '.dotfiles', source_dir, file
  src_path_pretty = File.join '~/.dotfiles', source_dir, file
  dest_path = dest_dir == nil ? File.join(HOME, file) : File.join(HOME, dest_dir, file)
  dest_path_pretty = dest_dir == nil ? File.join('~', file) : File.join('~', dest_dir, file)

  if File.symlink? dest_path
    sym_loc = File.readlink dest_path
    if sym_loc == src_path
      puts "#{file} is already symlinked. Skipping...".green
      return
    end
  end
  unless user_ask :default_confirm, "Do you want to symlink #{file}?"
    return
  end
  if File.symlink? dest_path
    File.delete dest_path
  end
  if File.exist? dest_path
    case backup file, dest_dir
    when :success
      puts "Backing up #{dest_path_pretty} -> #{dest_path_pretty}.backup".green
    when :failure
      puts "Couldn't back up file - #{dest_path_pretty}.backup already exists. Skipping...".red
      return
    end
  end
  puts "Symlinking #{dest_path_pretty} -> #{src_path_pretty}\n"
  File.symlink src_path, dest_path
end
