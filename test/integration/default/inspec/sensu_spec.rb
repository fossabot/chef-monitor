describe package('sensu') do
  it { should be_installed }
end

describe package('uchiwa') do
  it { should be_installed }
end

describe user('sensu') do
  it { should exist }
end

describe file('/etc/sensu') do
  it { should be_directory }
  it { should be_owned_by 'root' }
end

describe json('/etc/sensu/config.json') do
    # its(['transport','name']) { should eq 'rabbitmq'}
    # its(['rabbitmq',0,'host']) { should eq 'localhost'} # TODO: port should be 5671
    its(['redis','host']) { should eq 'localhost'} # TODO: port should be 6379
    its(['api','host']) { should eq 'localhost'} # TODO: port should be 4567
end

describe file('/etc/sensu/conf.d') do
  it { should be_directory }
  #  it { should be_owned_by 'sensu' }
end

describe file('/etc/sensu/conf.d/checks') do
  it { should be_directory }
  #  it { should be_owned_by 'sensu' }
end
describe file('/var/log/sensu') do
  it { should be_directory }
  it { should be_owned_by 'sensu' }
end

describe file('/var/log/sensu/sensu-api.log') do
  it { should be_file }
  it { should be_owned_by 'sensu' }
end

describe file('/var/log/sensu/sensu-client.log') do
  it { should be_file }
  it { should be_owned_by 'sensu' }
end

describe file('/var/log/sensu/sensu-server.log') do
  it { should be_file }
  it { should be_owned_by 'sensu' }
end

describe file('/etc/logrotate.d/sensu') do
  it { should be_file }
  it { should be_owned_by 'root' }
end

describe 'sensu client' do
  it 'is listening on port 3030' do
    expect(port(3030)).to be_listening
  end

  it 'has a running service of sensu-client' do
    expect(service('sensu-client')).to be_running
  end

  it 'has a enabled service of sensu-client' do
    expect(service('sensu-client')).to be_enabled
  end
end

describe 'sensu api' do
  it 'is listening on port 4567' do
    expect(port(4567)).to be_listening
  end

  it 'has a running service of sensu-api' do
    expect(service('sensu-api')).to be_running
  end

  it 'has a enabled service of sensu-api' do
    expect(service('sensu-api')).to be_enabled
  end
end

describe 'sensu server' do
  it 'has a running service of sensu-server' do
    expect(service('sensu-server')).to be_running
  end

  it 'has a enabled service of sensu-server' do
    expect(service('sensu-server')).to be_enabled
  end
end

describe 'uchiwa' do
  it 'is listening on port 3000' do
    expect(port(3000)).to be_listening
  end

  # it 'has a running service of uchiwa' do
  #   expect(service('uchiwa')).to be_running
  # end

  it 'has a enabled service of uchiwa' do
    expect(service('uchiwa')).to be_enabled
  end
end

describe command('curl -s http://localhost:3000/') do
  # test uchiwa login page
  its(:stdout) { should include('uchiwa') }
end

describe command('curl -s -I "http://localhost:4567/health?consumers=1&messages=1"') do
  # test output
  its(:stdout) { should include('HTTP/1.1 204') }
end

describe command('curl -s "http://localhost:4567/info') do
  # test rabbitmq connect
    # its(['transport','connected']) { should eq true}
    its(['redis','connected']) { should eq true}
end

# control 'check_clients' do
#  json_obj = json({ command: 'curl -s "http://localhost:4567/clients"'})
#  describe json_obj.length do
#    it {should > 0}
#  end
# end

describe command('curl -s http://localhost:4567/events') do
  its(:stdout) { should eq('[]') }
end

describe command('curl -s http://localhost:4567/stashes') do
  its(:stdout) { should eq('[]') }
end
