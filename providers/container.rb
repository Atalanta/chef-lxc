action :create do

  log "Creating container: #{new_resource.name}"

  directory "#{node['lxc']['container_path']}/#{new_resource.name}/rootfs" do
    recursive true
  end
  
   remote_file "#{node['lxc']['container_path']}/#{node['lxc']['template']}" do
     source "#{node['lxc']['template_path']}/#{node['lxc']['template']}"
     action :create_if_missing
   end

   execute "Extract LXC Template" do
     command "tar xzvf #{node['lxc']['container_path']}/#{node['lxc']['template']}"
     cwd "#{node['lxc']['container_path']}/#{new_resource.name}/rootfs"
     creates "#{node['lxc']['container_path']}/#{new_resource.name}/rootfs/etc/issue"
   end

   template "#{node['lxc']['container_path']}/#{new_resource.name}/fstab" do
     source "fstab.erb"
     variables( :name => new_resource.name )
   end

   template "#{node['lxc']['container_path']}/#{new_resource.name}/#{new_resource.name}.conf" do
     source "lxc-conf.erb"
     variables( :name => new_resource.name, :ip => new_resource.ipaddress )
   end

   template "#{node['lxc']['container_path']}/#{new_resource.name}/rootfs/etc/rc.sysinit" do
     source "rc.sysinit.erb"
     variables(
               :gateway => (node['equote']['subnet'].split(".")[0..2] << "1").join("."),
               :domain => node['equote']['domain'],
               :nameserver => node['lxc']['nameserver']
               )
   end

   execute "Create container" do
     command "lxc-create -n #{new_resource.name} -f #{node['lxc']['container_path']}/#{new_resource.name}/#{new_resource.name}.conf"
     creates "/usr/local/var/lib/lxc/#{new_resource.name}"
   end

   log "#{new_resource.name} provisioned and ready to start!"
   log "Enter GNU Screen and run `lxc-start -n #{new_resource.name}`"

end
