# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.dirname(__FILE__) + '/market_beat/yahoo'
require File.dirname(__FILE__) + '/market_beat/google'
require File.dirname(__FILE__) + "/market_beat/version"

module MarketBeat

  @@proxy_address = nil
  @@proxy_port    = nil
  @@has_proxy     = false

  # Pre-cache available methods so we could use them within
  # method_missing where respond_to? gives false positives.
  if RUBY_VERSION < '1.9.0'
    @@yahoo  = (Yahoo.methods  - Object.methods).map { |m| m.to_sym }
    @@google = (Google.methods - Object.methods).map { |m| m.to_sym }
  else
    @@yahoo  = Yahoo.methods  - Object.methods
    @@google = Google.methods - Object.methods
  end

  # Set global proxy address
  def self.set_proxy_address(address)
      @@proxy_address = address
      set_sources_proxy if @@proxy_port
  end

  # Set global proxy port
  def self.set_proxy_port(port)
      @@proxy_port = port
      set_sources_proxy if @@proxy_address
  end

  # Get global proxy address
  def self.get_proxy_address
      @@proxy_address
  end

  # Get global proxy address
  def self.get_proxy_port
      @@proxy_port
  end

  # Proxy configured?
  def self.set_sources_proxy
    Yahoo.set_proxy(@@proxy_address, @@proxy_port) 
    Google.set_proxy(@@proxy_address, @@proxy_port)
  end

  # Proxy MarketBeat methods to either Google or Yahoo providers.
  def self.method_missing(method, *args, &blk)
    if @@google.include?(method)
      Google.send(method, *args)
    elsif @@yahoo.include?(method)
      Yahoo.send(method, *args)
    else
      super
    end
  end

end
