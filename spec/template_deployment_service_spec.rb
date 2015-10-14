########################################################################
# template_deployment_service_spec.rb
#
# Test suite for the Azure::Armrest::TemplateDeploymentService class.
########################################################################
require 'spec_helper'

describe "TemplateDeploymentService" do
  before { setup_params }
  let(:tds) { Azure::Armrest::TemplateDeploymentService.new(@conf) }
  let(:url_prefix) { "https://management.azure.com/subscriptions/abc-123-def-456/resourceGroups/groupname/providers/Microsoft.Resources/deployments" }

  context "inheritance" do
    it "is a subclass of ArmrestService" do
      expect(Azure::Armrest::TemplateDeploymentService.ancestors).to include(Azure::Armrest::ArmrestService)
    end
  end

  context "constructor" do
    it "returns a TDS instance as expected" do
      expect(tds).to be_kind_of(Azure::Armrest::TemplateDeploymentService)
    end
  end

  context "instance methods" do
    it "defines a create method" do
      expected_url = url_prefix + "/deployname?api-version=2014-04-01-preview"
      expect(RestClient).to receive(:put).with(expected_url, anything, anything).and_return('{}')
      tds.create('deployname', {}, 'groupname')
    end

    it "defines a delete method" do
      expected_url = url_prefix + "/deployname?api-version=2014-04-01-preview"
      expect(RestClient).to receive(:delete).with(expected_url, anything)
      tds.delete('deployname', 'groupname')
    end

    it "defines a list_names method" do
      expected_url = url_prefix + "?api-version=2014-04-01-preview"
      expected_return = '{"value":[{"name":"deployname"}]}'
      expect(RestClient).to receive(:get).with(expected_url, anything).and_return(expected_return)
      tds.list_names('groupname')
    end

    it "defines a list method" do
      expected_url = url_prefix + "?api-version=2014-04-01-preview"
      expect(RestClient).to receive(:get).with(expected_url, anything).and_return('{"value":{}}')
      tds.list('groupname')
    end

    it "defines a get method" do
      expected_url = url_prefix + "/deployname?api-version=2014-04-01-preview"
      expect(RestClient).to receive(:get).with(expected_url, anything).and_return('{}')
      tds.get('deployname', 'groupname')
    end

    it "defines a list_deployment_operations method" do
      expected_url = url_prefix + "/deployname/operations?api-version=2014-04-01-preview"
      expect(RestClient).to receive(:get).with(expected_url, anything).and_return('{"value":{}}')
      tds.list_deployment_operations('deployname', 'groupname')
    end

    it "defines a get_deployment_operation method" do
      expected_url = url_prefix + "/deployname/operations/opid?api-version=2014-04-01-preview"
      expect(RestClient).to receive(:get).with(expected_url, anything).and_return('{}')
      tds.get_deployment_operation('deployname', 'opid', 'groupname')
    end
  end
end
