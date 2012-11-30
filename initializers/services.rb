# require services
Dir.glob(File.dirname(__FILE__)+"/../services/*.rb").each do |service|
  require_relative service
end

