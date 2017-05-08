default['monitor']['nagios_plugin_packages'] = ['nagios-plugins']

default['monitor']['sensu_plugins']['network-checks'] = '1.1.0'
default['monitor']['sensu_plugins']['load-checks'] = '1.0.0'
default['monitor']['sensu_plugins']['cpu-checks'] = '1.0.0'
default['monitor']['sensu_plugins']['process-checks'] = '1.0.0'
default['monitor']['sensu_plugins']['memory-checks'] = '2.1.0'
default['monitor']['sensu_plugins']['disk-checks'] = '2.0.1'
default['monitor']['sensu_plugins']['filesystem-checks'] = '0.2.0'
default['monitor']['sensu_plugins']['vmstats'] = '1.0.0'
default['monitor']['sensu_plugins']['io-checks'] = '1.0.0'
default['monitor']['sensu_plugins']['logs'] = '1.0.0'

default['monitor']['sensu_plugins']['windows'] = 'latest' if node[:platform_family].include?("windows")

default['monitor']['sensu_optional_plugins']['slack'] = '1.0.0'
