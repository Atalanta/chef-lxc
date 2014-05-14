include_recipe "network"
include_recipe "network::bridge"

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
