$HOME = ENV['HOME']

##
# Returns +true+ if the string +'--no-backup--'+ appears anywhere in +file+
def should_backup(file)
  matches_found = File.readlines(file).grep(/--no-backup--/)
  matches_found.size > 0
end

def backup(file)
  path = File.join $HOME, file
  backup_path = File.join $HOME, "#{file}.backup"

  unless File.exist? backup_path
    File.rename path, backup_path
    :success
  else
    :failure
  end
end
