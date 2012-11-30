# setup ldap
require 'ldap_lookup'
require 'yaml'
LDAPLookup::Importable.settings = YAML.load(File.read('config/ldap.yml'))[SINATRA_ENV]

