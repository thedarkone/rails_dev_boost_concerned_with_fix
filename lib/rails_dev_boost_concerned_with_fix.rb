# ConcernedWithRailsDevBoost
module RailsDevBoostConcernedWithFix
  
  def concerned_with_with_dependency_tracking(*args)
    concerned_with_without_dependency_tracking(*args)
    args.each do |dependency|
      dep_file_path = ActiveSupport::Dependencies.search_for_file("#{name.underscore}/#{dependency}".to_s)
      # Handle the case, when the parent object is changed, i.e. - make sure require_dependency does go through next time
      ActiveSupport::Dependencies.loaded.delete(dep_file_path.sub(/\.rb\Z/, ''))
      # Handle the case, when concerned_with file changes by associating a dummy constant with it and setting the parent object to be its dependency.
      dummy_const_name = "ConcernedWith__#{name.underscore}_#{dependency}"
      const_set(dummy_const_name, Module.new)
      dummy_const_full_name = "#{name}::#{dummy_const_name}"
      # track the concerned_with file
      ActiveSupport::Dependencies.associate_constants_to_file([dummy_const_full_name], dep_file_path)
      ActiveSupport::Dependencies.add_explicit_dependency(dummy_const_full_name, name)
    end
  end
  
  def self.included(base)
    base.alias_method_chain :concerned_with, :dependency_tracking
  end
  
end