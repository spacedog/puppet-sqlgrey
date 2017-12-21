require 'spec_helper'

describe 'sqlgrey::install' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "sqlgrey::install class without any parameters" do
          it do
            expect { should compile.with_all_deps }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
          end
        end
        context "sqlgrey::install class with all parameters defined" do
          let (:params) do
            {
              'package_ensure' => 'installed',
              'package_name'   => 'sqlgrey',
            }
          end
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_package('sqlgrey').with_ensure('installed') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'sqlgrey class without any parameters on Solaris/Nexenta' do
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
