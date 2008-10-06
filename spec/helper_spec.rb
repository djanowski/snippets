require File.dirname(__FILE__) + '/spec_helper'

class Template
  include Snippets::Helper

  def capture(&block)
    yield
    eval('_erbout', block.binding)
  end
end

describe Snippets do
  describe 'helper' do
    before(:each) do
      @template = Template.new
    end

    it "provides a helper method to ActionView" do
      Snippet.stub!(:get).with('homepage1', anything).and_return('Lorem ipsum')
      @template.snippet('homepage1').should == 'Lorem ipsum'
    end

    it "captures the view block and uses it as the default content for the snippet" do
      Snippet.should_receive(:get).with('homepage2', hash_including(:text => 'This is the default text'))

      _erbout = ''

      @template.snippet('homepage2') do
        _erbout << 'This is the default text'
      end
    end
  end
end
