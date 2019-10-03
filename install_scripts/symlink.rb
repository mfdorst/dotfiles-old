##
# For compatibility with 1.8
def require_rel(this_file, required_file)
  require File.join(File.dirname(this_file), required_file)
end

require_rel __FILE__, 'backup'
require_rel __FILE__, 'user_ask'

def symlink(dir, file)
  src_path = File.join HOME, '.dotfiles', dir, file
  src_path_pretty = File.join '~/.dotfiles', dir, file
  dest_path = File.join HOME, file

  if File.symlink? dest_path
    sym_loc = File.readlink dest_path
    if sym_loc == src_path
      puts "#{file} is already symlinked. Skipping..."
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
    case backup file
    when :success
      puts "Backing up ~/#{file} -> ~/#{file}.backup"
    when :failure
      puts "Couldn't back up file - ~/#{file}.backup already exists. Skipping..."
      return
    end
  end
  puts "Symlinking #{file} -> #{src_path_pretty}\n"
  File.symlink src_path, dest_path
end
