require 'mite-rb'

['MITE_INSTANCE', 'MITE_API_KEY'].each do |envvar|
  if not ENV.include?(envvar)
    raise "Environment variable #{envvar} not set. :("
  end
end

def get_connection()
  Mite.account = ENV['MITE_INSTANCE']
  Mite.key = ENV['MITE_API_KEY']
  Mite.user_agent = 'mitefred'
  Mite.validate!
  Mite
end