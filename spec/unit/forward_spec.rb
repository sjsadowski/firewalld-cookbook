require 'spec_helper'

describe 'fixture::forward' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

    it 'adds forward port 443' do
      expect(chef_run).to add_firewalld_forward('443/tcp:8443')
    end

    it 'removes forward port 443' do
      expect(chef_run).to remove_firewalld_forward('443/tcp:8443')
    end
end
