#require 'getoptlong'
require '../../src/configuration-api'

# Add current directory into path for Ruby modules
$LOAD_PATH << '.'

$opts = ConfigurationApi.get_opts()
$cfg = ConfigurationApi.init_cfg($opts)
$home_dir = File.expand_path('~')
