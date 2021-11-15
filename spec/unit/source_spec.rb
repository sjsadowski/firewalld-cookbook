require 'spec_helper'

describe 'fixture::source' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'enables, and starts firewalld service' do
    expect(chef_run).to enable_service('firewalld')
    expect(chef_run).to start_service('firewalld')
  end

  it 'changes source 192.168.0.0/24' do
    expect(chef_run).to change_firewalld_source('192.168.0.0/24')
  end

  it 'removes source 192.168.1.0/24' do
    expect(chef_run).to remove_firewalld_source('192.168.1.0/24')
  end
end
