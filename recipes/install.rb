package 'screen'

remote_file '/tmp/lxc-libs-1.0.3-1.el6.x86_64.rpm' do
  source 'https://s3-eu-west-1.amazonaws.com/c6lxc/lxc-libs-1.0.3-1.el6.x86_64.rpm'
  notifies :run, 'execute[Install LXC Libs]'
end

remote_file '/tmp/lxc-1.0.3-1.el6.x86_64.rpm' do
  source 'https://s3-eu-west-1.amazonaws.com/c6lxc/lxc-1.0.3-1.el6.x86_64.rpm'
  notifies :run, 'execute[Install LXC]'
end

execute 'Install LXC Libs' do
  command 'yum -y localinstall /tmp/lxc-libs-1.0.3-1.el6.x86_64.rpm'
  action :nothing
end

execute 'Install LXC' do
  command 'yum -y localinstall /tmp/lxc-1.0.3-1.el6.x86_64.rpm'
  action :nothing
end
