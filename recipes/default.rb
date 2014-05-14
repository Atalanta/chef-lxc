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

ark "lxc" do
  url "http://lxc.sourceforge.net/download/lxc/lxc-0.9.0.tar.gz"
  action [:configure, :install_with_make]
end

