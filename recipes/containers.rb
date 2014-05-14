containers = data_bag_item("lxc", "containers")

containers[node['hostname']].each do |name, ip|
  log "Creating #{name} with #{ip}"
   lxc_container name do
     ipaddress ip
     action :create
   end
end 
