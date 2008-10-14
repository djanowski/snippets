require File.dirname(__FILE__) + '/spec_helper'

describe Snippet do
  it "is identified by slug" do
    create(:slug => 'homepage')

    Snippet.get('homepage').should == 'Lorem ipsum'
    Snippet.get('Homepage').should == 'Lorem ipsum'

    lambda { create(:slug => '') }.should raise_error
  end

  it "does nothing as a default parsing method" do
    create(:slug => 'copy1', :text => 'Gems > Plugins')

    Snippet.get('copy1').should == 'Gems > Plugins'
  end

  describe 'parsing methods' do
    it "can take plain text" do
      create(:slug => 'copy9', :text => 'Gems > Plugins', :parser => 'plain_text')

      Snippet.get('copy9').should == 'Gems &gt; Plugins'
    end

    it "can take Textile" do
      create(:slug => 'copy6', :text => '*A snippet*', :parser => 'textile')

      Snippet.get('copy6').should == '<p><strong>A snippet</strong></p>'
    end

    it "raises when it can't find a parser" do
      lambda { Snippet.get('copy7', :parser => 'made_up_parser') }.should raise_error
      lambda { Snippet.parse('Some text', nil) }.should_not raise_error
    end

  end

  it "is unique by slug" do
    lambda { 2.times { create(:slug => 'the_same_slug') } }.should raise_error
  end

  it "creates the requested snippet on the fly" do
    create(:slug => 'copy2')

    lambda { Snippet.get('copy2') }.should_not change(Snippet, :count)

    lambda { Snippet.get('copy3') }.should change(Snippet, :count).by(1)

    Snippet.get('copy4').should be_empty

    Snippet.get('copy5', :text => 'Dolor sit amet').should == 'Dolor sit amet'
    Snippet.find_by_slug('copy5').text.should == 'Dolor sit amet'
  end

  describe "with variables" do
    it "can receive an array of parameters (sprintf-like)" do
      create(:slug => 'copy_with_params', :text => 'Hello, %s!')

      (Snippet.get('copy_with_params') % 'world').should == 'Hello, world!'
    end

    it "can receive named variables as a hash" do
      create(:slug => 'copy_with_named_params', :text => 'Hello, {{name}} {{surname}}!')

      (Snippet.get('copy_with_named_params') % {:name => 'Albert', :surname => 'Einstein'}).should == 'Hello, Albert Einstein!'
    end
  end
end
