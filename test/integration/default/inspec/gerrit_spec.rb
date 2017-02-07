control 'gerrit-1' do
  title 'Gerrit Setup'
  desc '
    Check that gerrit is installed and running
  '

  describe directory('/var/gerrit/review/etc') do
    it { should exist }
  end

  [8080, 29418].each do |listen_port|
    describe port(listen_port) do
      it { should be_listening }
      its('protocols') { should include 'tcp6'}
    end
  end

  # port 8080 HTML
  describe command('curl http://localhost:8080') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include '<title>Gerrit Code Review</title>' }
  end

  # check heap limit (defined in t3-gerrit)
  # jmap -heap <java-proc>
  describe command('sudo -H -u gerrit jmap -heap $(pgrep java) | grep MaxHeapSize') do
    its('stdout') { should include '2048.0MB' }
  end
end