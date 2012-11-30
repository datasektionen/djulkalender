# require models
Dir.glob(File.dirname(__FILE__)+"/../models/*.rb").each do |model|
  require_relative model
end

