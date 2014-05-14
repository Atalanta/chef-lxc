include_recipe "network"
include_recipe "network::bridge"
include_recipe "build-essential"
include_recipe "ark"

network_config "br0" do
  dhcp true
  onboot true
  nm_controlled false
  bridge true 
  action :create
end

network_config "eth0" do
  onboot true
  bridge "br0"
  nm_controlled false
  action :create
end

package "libcap-devel"
package "screen"

remote_file '/tmp/lxc-1.0.3-1.el6.x86_64.rpm' do
  source 'https://s3-eu-west-1.amazonaws.com/c6lxc/lxc-1.0.3-1.el6.x86_64.rpm'
  notifies :run, 'execute[Install LXC]'
end

execute 'Install LXC' do
  command 'yum localinstall /tmp/lxc-1.0.3-1.el6.x86_64.rpm'
  action :nothing
end

