# require models
Dir.glob(File.dirname(__FILE__)+"/../policies/*.rb").each do |policy|
  require_relative policy
end

