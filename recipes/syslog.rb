papertrail_host = node[:papertrail][:host]
papertrail_port = node[:papertrail][:port] or raise 'Must set papertrail port!'
papertrail_cert = '/etc/papertrail-bundle.pem'

include_recipe 'apt'
package 'rsyslog-gnutls'

remote_file papertrail_cert do
  source 'https://papertrailapp.com/tools/papertrail-bundle.pem'
  checksum 'c03a504397dc45b4fc05f978dbf02129793cbd2a0b64856c2ba1bb49a3b9aacb'
  mode 0644
end

file '/etc/rsyslog.d/90-tls.conf' do
  content <<-CONF
$DefaultNetstreamDriverCAFile #{papertrail_cert}
$ActionSendStreamDriver gtls
$ActionSendStreamDriverMode 1 # require TLS
$ActionSendStreamDriverAuthMode x509/name # authenticate by hostname
$ActionSendStreamDriverPermittedPeer *.papertrailapp.com

  CONF
  notifies :restart, 'service[rsyslog]', :delayed
end

file '/etc/rsyslog.d/99-papertrail.conf' do
  content "*.*          @@#{papertrail_host}:#{papertrail_port}"
  notifies :restart, 'service[rsyslog]', :delayed
end

service 'rsyslog' do
  action :nothing
  provider Chef::Provider::Service::Upstart
end
