require 'spec_helper'

describe 'fixture::rich_rule' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it "enables and starts firewalld service" do
    expect(chef_run).to enable_service('firewalld')
    expect(chef_run).to start_service('firewalld')
  end

  it "adds rule for ssh" do
    expect(chef_run).to add_firewalld_rich_rule("ssh add")
  end

  it "removes rule for ssh" do
    expect(chef_run).to remove_firewalld_rich_rule("ssh remove")
  end

end
