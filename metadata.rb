name        'papertrail'
maintainer  'Sam Stokes'
maintainer  'me@samstokes.co.uk'
description <<-DESC
Send logs via syslog to Papertrail
DESC
version     '0.0.2'

recipe      'papertrail', 'Send syslog and application logs to Papertrail'
recipe      'papertrail::syslog', 'Send syslog to Papertrail'
recipe      'papertrail::app', 'Send application logs to Papertrail'

attribute   'papertrail/host',
              :display_name => 'Papertrail host',
              :description => 'Papertrail destination hostname',
              :type => 'string',
              :required => 'recommended',
              :default => 'logs.papertrailapp.com'
attribute   'papertrail/port',
              :display_name => 'Papertrail port',
              :description => 'Papertrail destination port allocated for your systems',
              :type => 'string',
              :required => 'required'
attribute   'papertrail/log_files',
              :display_name => 'App log files',
              :description => 'App log files to watch and send to Papertrail',
              :type => 'array',
              :required => 'recommended'

depends     'apt'

supports 'ubuntu'
