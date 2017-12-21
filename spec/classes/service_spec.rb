describe 'sqlgrey::service' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "sqlgrey::service class without any parameters" do
          it do
            expect { should compile.with_all_deps }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
          end
        end
        context "sqlgrey::service class with all parameters defined" do
          let (:params) do
            {
              'service_name'   => 'sqlgrey',
              'service_ensure' => 'running',
              'service_enable' => true,
            }
          end
          it do
            is_expected.to contain_service('sqlgrey').with({
              'ensure' => 'running',
              'enable' => true,
            })
          end
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
