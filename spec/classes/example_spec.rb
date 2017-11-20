require 'spec_helper'

describe 'role_appl' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo",
            :monitor_address => "localhost",
            :nfs_address => "localhost",
            :db_address => "localhost",
            :ext_lb_fqdn => "localhost",
            :win_address => "localhost",
            :ssl_cert_path => "/etc/ssl/certs/ssl-cert-default.pem",
            :ssl_key_path => "/etc/ssl/private/ssl-cert-default.key",
          })
        end

        context "role_appl class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('role_appl') }
          it { is_expected.to contain_class('profile_base') }
          it { is_expected.to contain_apache__vhost('foo.example.com non-ssl').with( 'ssl' => false ) }
          it { is_expected.to contain_apache__vhost('foo.example.com ssl').with( 'ssl' => true ) }

          it { is_expected.to contain_apache__listen('80') }  
          it { is_expected.to contain_apache__listen('443') }

        end
      end
    end
  end
end
