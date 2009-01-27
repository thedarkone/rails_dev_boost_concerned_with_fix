if Rails.env.development?
  if defined?(:ConcernedWith) && defined?(:RailsDevelopmentBoost)
    ConcernedWith.send :include, RailsDevBoostConcernedWithFix
  else
    Rails.logger.warn "concerned_with_rails_dev_boost needs to be loaded *after* concerned_with and rails-dev-boost plugins."
  end
end