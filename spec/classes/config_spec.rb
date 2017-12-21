require 'spec_helper'

describe 'sqlgrey::config' do
  let :default_params do
    {
      'db_tag'                 => '',
      'manage_db'              => true,
      'db_export'              => false,
      'clients_fqdn_whitelist' => [],
      'clients_ip_whitelist'   => [],
      'config'                 => {
        'param1' => {
          'value' => 'value1'
        },
        'param2' => {
          'value' => 'value2'
        },
      }
    }
  end
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "sqlgrey::config class without any parameters" do
          it do
            expect { should compile.with_all_deps }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
          end
        end
        context "sqlgrey::config class with all parameters defined" do
          let (:params) do
            default_params
          end
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_sqlgrey__config__param('param1') }
          it { is_expected.to contain_sqlgrey__config__param('param2') }
          it { is_expected.to contain_augeas('sqlgrey-param-param1') }
          it { is_expected.to contain_augeas('sqlgrey-param-param2') }

          context "sqlgrey::config with only db_type = mysql" do
            let (:params) do
              default_params.merge({
                  'config'                 => {
                    'db_type'=> {
                      'value' => 'mysql'
                    },
                    'param1' => {
                      'value' => 'value1'
                    },
                    'param2' => {
                      'value' => 'value2'
                    },
                  }
                })
            end
            it do
              expect { should compile.with_all_deps }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
            end
          end
          context "sqlgrey::config with db_type = mysql and db info" do
            let (:params) do
              default_params.merge({
                'config' => {
                  'db_type'=> {
                    'value' => 'mysql'
                  },
                  'db_user'=> {
                    'value' => 'user'
                  },
                  'db_pass'=> {
                    'value' => 'password'
                  },
                  'db_name'=> {
                    'value' => 'db'
                  },
                  'db_host'=> {
                    'value' => 'hostname'
                  },
                  'param1' => {
                    'value' => 'value1'
                  },
                  'param2' => {
                    'value' => 'value2'
                  },
                }
              })
            end
            it do
              is_expected.to compile.with_all_deps
              is_expected.to contain_augeas('sqlgrey-param-db_type')
              is_expected.to contain_augeas('sqlgrey-param-db_user')
              is_expected.to contain_augeas('sqlgrey-param-db_pass')
              is_expected.to contain_augeas('sqlgrey-param-db_name')
              is_expected.to contain_augeas('sqlgrey-param-db_host')
              is_expected.to contain_sqlgrey__config__param('db_type')
              is_expected.to contain_sqlgrey__config__param('db_user')
              is_expected.to contain_sqlgrey__config__param('db_pass')
              is_expected.to contain_sqlgrey__config__param('db_name')
              is_expected.to contain_sqlgrey__config__param('db_host')
            end

            context "sqlgrey::config with db_type = mysql and db info and db_export false" do
              let(:params) do
                default_params.merge({
                  'db_export' => false,
                  'config' => {
                    'db_type'=> {
                      'value' => 'mysql'
                    },
                    'db_user'=> {
                      'value' => 'user'
                    },
                    'db_pass'=> {
                      'value' => 'password'
                    },
                    'db_name'=> {
                      'value' => 'db'
                    },
                    'db_host'=> {
                      'value' => 'hostname'
                    },
                    'param1' => {
                      'value' => 'value1'
                    },
                    'param2' => {
                      'value' => 'value2'
                    },
                  }
                })
              end
              it do
                is_expected.to contain_mysql__db('sqlgrey').with_ensure('present')
                is_expected.to contain_mysql__db('sqlgrey').with_user('user')
                is_expected.to contain_mysql__db('sqlgrey').with_password('password')
                is_expected.to contain_mysql__db('sqlgrey').with_dbname('db')
                is_expected.to contain_mysql__db('sqlgrey').with_host('hostname')
              end
            end
            context "sqlgrey::config with db_type = mysql and db info and db_export true" do
              let(:params) do
                default_params.merge({
                  'db_export' => true,
                  'db_tag'    => 'export_tag',
                  'config'    => {
                    'db_type'=> {
                      'value' => 'mysql'
                    },
                    'db_user'=> {
                      'value' => 'user'
                    },
                    'db_pass'=> {
                      'value' => 'password'
                    },
                    'db_name'=> {
                      'value' => 'db'
                    },
                    'db_host'=> {
                      'value' => 'hostname'
                    },
                    'param1' => {
                      'value' => 'value1'
                    },
                    'param2' => {
                      'value' => 'value2'
                    },
                  }
                })
              end
              it do
                is_expected.to contain_mysql__db('sqlgrey_foo.example.com').with_ensure('present')
                is_expected.to contain_mysql__db('sqlgrey_foo.example.com').with_user('user')
                is_expected.to contain_mysql__db('sqlgrey_foo.example.com').with_password('password')
                is_expected.to contain_mysql__db('sqlgrey_foo.example.com').with_dbname('db')
                is_expected.to contain_mysql__db('sqlgrey_foo.example.com').with_host(facts[:ipaddress])
                is_expected.to contain_mysql__db('sqlgrey_foo.example.com').with_tag('export_tag')
              end
            end
          end
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'sqlgrey::config class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end
      it do
        expect { should compile.with_all_deps }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
