require 'spec_helper'

describe 'fixture::masquerade' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'enables, and starts firewalld service' do
    expect(chef_run).to enable_service('firewalld')
    expect(chef_run).to start_service('firewalld')
  end

  it 'adds masquerade to public zone' do
    expect(chef_run).to add_firewalld_masquerade('public')
  end

  it 'removes masquerade from public zone' do
    expect(chef_run).to remove_firewalld_masquerade('public')
  end
end
