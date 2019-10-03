def backup(file)
  path = File.join HOME, file
  backup_path = File.join HOME, "#{file}.backup"

  unless File.exist? backup_path
    File.rename path, backup_path
    :success
  else
    :failure
  end
end
