require File.join(File.dirname(__FILE__), '..', 'lib', 'snippets', 'helper')

ActionView::Base.send(:include, Snippets::Helper)
