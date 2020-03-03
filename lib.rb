require 'mite-rb'

['MITE_INSTANCE', 'MITE_API_KEY'].each do |envvar|
  if not ENV.include?(envvar)
    raise "Environment variable #{envvar} not set. :("
  end
end

$cache = ActiveSupport::Cache::FileStore.new("./cache", expires_in: 30.seconds)

def get_connection()
  Mite.account = ENV['MITE_INSTANCE']
  Mite.key = ENV['MITE_API_KEY']
  Mite.user_agent = 'mitefred'
  unless $cache.exist? 'validated'
    Mite.validate!
    $cache.write('validated', expires_in: 1.day)
  end
  Mite
end
