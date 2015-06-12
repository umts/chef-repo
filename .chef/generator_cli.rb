class GeneratorCLI
  include Mixlib::CLI
  self.options = ChefDK::Command::SharedGeneratorOptions.options.merge(

    license:            Chef::Config[:cookbook_license],
    generator_cookbook: File.join(File.dirname(__FILE__), '..', 'code_generator'),
    copyright_holder:   Chef::Config[:cookbook_copyright],
    email:              Chef::Config[:cookbook_email]

  ){ |k, ov, nv| ov.merge(default: nv) }
end
