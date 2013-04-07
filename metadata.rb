name        'papertrail'
maintainer  'Sam Stokes'
maintainer  'me@samstokes.co.uk'
description <<-DESC
Send logs via syslog to Papertrail
DESC
version     '0.0.1'

recipe      'papertrail', 'Send logs via syslog to Papertrail'

attribute   'papertrail/port',
              :display_name => 'Papertrail port',
              :description => 'Papertrail port allocated for your systems',
              :type => 'string',
              :required => 'required'

supports 'ubuntu'
