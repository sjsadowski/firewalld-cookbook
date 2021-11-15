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

describe 'fixture::port' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'installs firewalld' do
    expect(chef_run).to install_package('firewalld')
  end

  it 'adds port 993/tcp' do
    expect(chef_run).to add_firewalld_port('993/tcp')
  end

  it 'removes port 1001/tcp' do
    expect(chef_run).to remove_firewalld_port('1001/tcp')
  end
end
