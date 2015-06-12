#Pull in all of the values defined in the `chefdk` context in knife.rb
Chef::Config[:chefdk].configuration.each do |config_key, value|
  ChefDK::Generator.context.send("#{config_key}=", value)
end
