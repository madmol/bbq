if Rails.env.production?
  Resque.logger = Logger.new(Rails.root.join('log', "#{Rails.env}_resque.log"))
  Resque.logger.level = Logger::WARN
  Resque.redis = 'localhost:6379'
end
