# Copyright (c) 2011-12 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require "stringio"
require "date"

describe "MarketBeat::Historical" do
  before(:all) do
    @csv = File.read(File.dirname(__FILE__) + '/fixtures/AAPL.csv')
  end

  it "should return correct data when using strings as start/end dates" do
    response = mock(:body => @csv)
    Net::HTTP.should_receive(:get_response).once.and_return(response)
    quotes = MarketBeat.quotes(:aapl, "2011-12-21", "2011-12-23")
    quotes.size.should == 3
    quotes[0].keys.map(&:to_s).sort.should == %w(close date high low open volume)
    quotes[0][:open].should      == "403.43"
    quotes[0][:high].should      == "403.43"
    quotes[0][:low].should       == "403.43"
    quotes[0][:close].should     == "403.43"
    quotes[0][:volume].should    == "0"
    quotes[0][:date].to_s.should == "2011-12-23"
    quotes[1][:date].to_s.should == "2011-12-22"
    quotes[2][:date].to_s.should == "2011-12-21"
  end

  it "should return correct data when using Date as start/end dates" do
    response = mock(:body => @csv)
    Net::HTTP.should_receive(:get_response).once.and_return(response)
    quotes = MarketBeat.quotes(:aapl, Date.parse("2011-12-21"), Date.parse("2011-12-23"))
    quotes.size.should == 3
    quotes[2].keys.map(&:to_s).sort.should == %w(close date high low open volume)
    quotes[2][:open].should      == "396.69"
    quotes[2][:high].should      == "397.30"
    quotes[2][:low].should       == "392.01"
    quotes[2][:close].should     == "396.44"
    quotes[2][:volume].should    == "9390954"
    quotes[2][:date].to_s.should == "2011-12-21"
    quotes[1][:date].to_s.should == "2011-12-22"
    quotes[0][:date].to_s.should == "2011-12-23"
  end

  it "should return empty array when no data is available" do
    response = mock(:body => @csv.split.first)  # Just the header row.
    Net::HTTP.should_receive(:get_response).once.and_return(response)
    MarketBeat.quotes(:aapl, "2011-12-21", "2011-12-23").should == []
  end

  it "should return nil on error" do
    begin
      stderr, $stderr = $stderr, StringIO.new
      response = mock(:body => "")
      Net::HTTP.should_receive(:get_response).once.and_raise(SocketError)
      MarketBeat.quotes(:aapl, "2011-12-21", "2011-12-23").should == nil
      $stderr.string.should =~ /^market_beat: error fetching quotes/m
    ensure
      $stderr = stderr
    end
  end
end

