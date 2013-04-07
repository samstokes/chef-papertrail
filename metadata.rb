name        'papertrail'
maintainer  'Sam Stokes'
maintainer  'me@samstokes.co.uk'
description <<-DESC
Send logs via syslog to Papertrail
DESC
version     '0.0.1'

recipe      'papertrail', 'Send syslog and application logs to Papertrail'
recipe      'papertrail::syslog', 'Send syslog to Papertrail'
recipe      'papertrail::app', 'Send application logs to Papertrail'

attribute   'papertrail/port',
              :display_name => 'Papertrail port',
              :description => 'Papertrail port allocated for your systems',
              :type => 'string',
              :required => 'required'
attribute   'papertrail/log_files',
              :display_name => 'App log files',
              :description => 'App log files to watch and send to Papertrail',
              :type => 'array',
              :required => 'recommended'

depends     'apt'

supports 'ubuntu'
