require File.dirname(__FILE__) + '/spec_helper'

describe Snippet do
  it "is identified by slug" do
    create(:slug => 'homepage')

    Snippet.get('homepage').should == 'Lorem ipsum'
    Snippet.get('Homepage').should == 'Lorem ipsum'

    lambda { create(:slug => '') }.should raise_error
  end

  it "does HTML escaping as a default parsing method" do
    create(:slug => 'copy1', :text => 'Gems > Plugins')

    Snippet.get('copy1').should == 'Gems &gt; Plugins'
  end

  it "allows for other parsing methods" do
    create(:slug => 'copy6', :text => '*A snippet*', :parser => 'textile')

    Snippet.get('copy6').should == '<p><strong>A snippet</strong></p>'

    lambda { Snippet.get('copy7', :parser => 'made_up_parser') }.should raise_error
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
end
