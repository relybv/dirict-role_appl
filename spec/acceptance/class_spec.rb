if ENV['BEAKER'] == 'true'
  # running in BEAKER test environment
  require 'spec_helper_acceptance'
else
  # running in non BEAKER environment
  require 'serverspec'
  set :backend, :exec
end

describe 'role_appl class' do

  context 'default parameters' do
    if ENV['BEAKER'] == 'true'
      # Using puppet_apply as a helper
      it 'should work with no errors' do
        pp = <<-EOS
        class { 'role_appl': }
        EOS

        apply_manifest(pp, :catch_failures => true)
      end
    end

   describe package('apache2') do
     it { is_expected.to be_installed }
   end

   describe service('apache2') do
     it { is_expected.to be_enabled }
     it { is_expected.to be_running }
   end

  end
end
