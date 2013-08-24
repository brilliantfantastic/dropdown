require_relative '../spec_helper'
require_relative '../../lib/dropdown'

describe Dropdown::Configuration do
  subject { Dropdown::Configuration.new }
  it 'sets defaults' do
    subject.renderer.should == :markdown_renderer
    subject.dropbox_app_key.should be_nil
    subject.dropbox_app_secret.should be_nil
    subject.dropbox_access_token.should be_nil
  end
end
