require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Configuration do
  subject { Dropdown::Configuration.new }
  it 'sets defaults' do
    subject.renderer.should == :markdown_renderer
    subject.dropdown_app_key.should be_nil
    subject.dropdown_app_secret.should be_nil
    subject.dropdown_access_token.should be_nil
  end
end
