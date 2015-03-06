## Required requires
require 'thor'
require 'dib/version'

# Initialize DIB thor class
class DIB < Thor
end

## Load plugins/modules here
require 'dib/rc'
require 'dib/to_slack'
# require 'dib/about'
# require 'dib/artifact'
# require 'dib/build'
# require 'dib/release'

