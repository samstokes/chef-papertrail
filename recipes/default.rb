papertrail_port = node[:papertrail][:port] or raise 'Must set papertrail port!'

file '/etc/rsyslog.d/99-papertrail.conf' do
  content "*.*          @logs.papertrailapp.com:#{papertrail_port}"
  notifies :restart, 'service[rsyslog]', :delayed
end

service 'rsyslog' do
  action :nothing
  provider Chef::Provider::Service::Upstart
end
