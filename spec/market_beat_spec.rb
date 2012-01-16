# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'yaml'

describe "MarketBeat Google Proxy" do
  metrics = YAML.load_file(File.dirname(__FILE__) + '/../lib/market_beat/google.yml')
  metrics.values.each do |method|
    if RUBY_VERSION > '1.9'
      it "MarketBeat should respond to :#{method}" do
        MarketBeat.respond_to?(method).should == true
      end
    end

    it "Google.#{method}" do
      MarketBeat::Google.should_receive(method).once
      MarketBeat::Yahoo.should_not_receive(method)
      MarketBeat.send(method, :msft)
    end
  end
end

describe "MarketBeat Yahoo Proxy" do
  yahoo_metrics  = YAML.load_file(File.dirname(__FILE__) + '/../lib/market_beat/yahoo.yml')
  google_metrics = YAML.load_file(File.dirname(__FILE__) + '/../lib/market_beat/google.yml')
  yahoo_metrics.values.each do |method|
    if RUBY_VERSION > '1.9'
      it "MarketBeat should respond to :#{method}" do
        MarketBeat.respond_to?(method).should == true
      end
    end

    it "Yahoo.#{method}" do # If Yahoo and Google have the same method Google takes precedence.
      if google_metrics.values.include?(method)
        MarketBeat::Google.should_receive(method).once
        MarketBeat::Yahoo.should_not_receive(method)
      else
        MarketBeat::Google.should_not_receive(method)
        MarketBeat::Yahoo.should_receive(method).once
      end
      MarketBeat.send(method, :msft)
    end
  end
end

describe "MarketBeat super passthrough" do
  it "unknown method invokes super" do
    lambda { MarketBeat.hello_world! }.should raise_error(NoMethodError)
  end
end

