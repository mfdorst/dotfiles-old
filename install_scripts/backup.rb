def backup(file, dir=nil)
  path = dir == nil ? File.join(HOME, file) : File.join(HOME, dir, file)
  backup_path = "#{path}.backup"

  unless File.exist? backup_path
    File.rename path, backup_path
    :success
  else
    :failure
  end
end
