module ConcernedWithDepPatch
  
  def unload_modified_files_with_concerned_fix
    file_map.each_value do |file|
      if file.concerned_with_parent && file.changed?
        file.mtime = 0 # keep it changed
        file_map[file.concerned_with_parent].mtime = 0 # propagate concerned_with changed status
      end
    end
    unload_modified_files_without_concerned_fix
  end
  
  def self.included(dep_mod)
    dep_mod.alias_method_chain :unload_modified_files, :concerned_fix
  end
  
end