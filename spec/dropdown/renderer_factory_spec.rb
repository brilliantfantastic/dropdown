require_relative '../spec_helper'
require_relative '../../lib/dropdown/renderer_factory'

describe Dropdown::RendererFactory do
  class FakeRenderer
    attr_reader :file
    def initialize(file)
      @file = file
    end
  end

  it 'creates a renderer with a type and a file' do
    file = double
    renderer = Dropdown::RendererFactory.create :fake_renderer, file
    renderer.should be_an_instance_of FakeRenderer
    renderer.file.should == file
  end
end
