require 'spec_helper'

describe 'fixture::interface' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'enables, and starts firewalld service' do
    expect(chef_run).to enable_service('firewalld')
    expect(chef_run).to start_service('firewalld')
  end

  it 'changes interface eth0' do
    expect(chef_run).to change_firewalld_interface('eth0')
  end

  it 'removes interface eth1' do
    expect(chef_run).to remove_firewalld_interface('eth1')
  end
end
