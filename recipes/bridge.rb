include_recipe "network"
include_recipe "network::bridge"

host_data = data_bag_item("lxc", "hosts")

if host_data[node['hostname']]['dhcp']

  network_config "br0" do
    dhcp true
    onboot true
    nm_controlled false
    bridge true 
    action :create
  end
  
else
  
  network_config "br0" do
    dhcp false
    ipaddr host_data[node['hostname']]['ipaddress']
    network host_data[node['hostname']]['network']
    gateway host_data[node['hostname']]['gateway']
    broadcast host_data[node['hostname']]['broadcast']     
    onboot true
    nm_controlled false
    bridge true 
    action :create
  end

end

network_config host_data[node['hostname']]['nic'] do
  onboot true
  bridge "br0"
  nm_controlled false
  action :create
end

