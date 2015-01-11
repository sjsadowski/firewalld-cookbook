require 'spec_helper'

describe 'firewalld::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'installs firewalld' do
    expect(chef_run).to install_package('firewalld')
  end

  it 'enables firewalld' do
    expect(chef_run).to enable_service('firewalld')
  end

  it 'starts firewalld' do
    expect(chef_run).to start_service('firewalld')
  end

end
