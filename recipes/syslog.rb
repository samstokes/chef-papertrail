papertrail_port = node[:papertrail][:port] or raise 'Must set papertrail port!'
papertrail_cert = '/etc/syslog.papertrail.crt'

include_recipe 'apt'
package 'rsyslog-gnutls'

remote_file papertrail_cert do
  source 'https://papertrailapp.com/tools/syslog.papertrail.crt'
  checksum '7d6bdd1c00343f6fe3b21db8ccc81e8cd1182c5039438485acac4d98f314fe10'
  mode 0644
end

file '/etc/rsyslog.d/90-tls.conf' do
  content <<-CONF
$DefaultNetstreamDriverCAFile #{papertrail_cert}
$ActionSendStreamDriver gtls
$ActionSendStreamDriverMode 1 # require TLS
$ActionSendStreamDriverAuthMode x509/name # authenticate by hostname
  CONF
  notifies :restart, 'service[rsyslog]', :delayed
end

file '/etc/rsyslog.d/99-papertrail.conf' do
  content "*.*          @@logs.papertrailapp.com:#{papertrail_port}"
  notifies :restart, 'service[rsyslog]', :delayed
end

service 'rsyslog' do
  action :nothing
  provider Chef::Provider::Service::Upstart
end
