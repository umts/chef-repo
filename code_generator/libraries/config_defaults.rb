#Stupid monkey-patch:
#Pull in all of the values defined in the `chefdk` context in knife.rb
#So the generator can access them with context.  Note that said knife file
#does some guarding to make sure command-line options take precedence
Chef::Config[:chefdk].keys.each do |config_key|
  ChefDK::Generator.context.send("#{config_key}=", Chef::Config[:chefdk][config_key])
end
