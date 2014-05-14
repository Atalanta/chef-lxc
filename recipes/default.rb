include_recipe "network"
include_recipe "network::bridge"
include_recipe "build-essential"
include_recipe "ark"

# TODO: This is fine for building
# Would be completely cool with a static IP
# Best would be for DHCP / DNS Masq to be working

# network_config "br0" do
#   dhcp true
#   onboot true
#   nm_controlled false
#   bridge true 
#   action :create
# end

# TODO: Make this come from elsewhere
network_config "p1p1" do
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

containers = data_bag_item("lxc", "containers")



containers[node['hostname']].each do |name, ip|
  puts "#{name} will be made with #{ip}"
   lxc_container name do
     ipaddress ip
     action :create
   end
end 
