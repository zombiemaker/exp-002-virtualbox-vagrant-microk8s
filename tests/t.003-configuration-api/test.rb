#require 'getoptlong'
require '../../src/configuration-api'

# Add current directory into path for Ruby modules
$LOAD_PATH << '.'

# # BUG: Need to handle vagrant options
# $opts = GetoptLong.new(
#     [ '--config-file', GetoptLong::REQUIRED_ARGUMENT],
#     [ '--schema-file', GetoptLong::REQUIRED_ARGUMENT],
#     [ '--debug', GetoptLong::OPTIONAL_ARGUMENT]
# )

$opts = ConfigurationApi.get_opts()
$cfg = ConfigurationApi.init_cfg($opts)
$home_dir = File.expand_path('~')
