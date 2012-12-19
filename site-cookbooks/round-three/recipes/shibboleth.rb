include_recipe "shibboleth"

web_app "round-three-shib" do
  template "round-three-shib.conf.erb"
end
