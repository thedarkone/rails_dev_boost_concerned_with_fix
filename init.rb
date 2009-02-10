if Rails.env.development?
  if defined?(:ConcernedWith) && defined?(:RailsDevelopmentBoost)
    RailsDevelopmentBoost::DependenciesPatch.send :include, ConcernedWithDepPatch
    ConcernedWith.send :include, RailsDevBoostConcernedWithFix
    RailsDevelopmentBoost::LoadedFile.class_eval do
      attr_writer :mtime
      attr_accessor :concerned_with_parent
    end
  else
    Rails.logger.warn "concerned_with_rails_dev_boost needs to be loaded *after* concerned_with and rails-dev-boost plugins."
  end
end