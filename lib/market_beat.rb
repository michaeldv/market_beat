# Copyright (c) 2011-12 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.dirname(__FILE__) + '/market_beat/yahoo'
require File.dirname(__FILE__) + '/market_beat/google'
require File.dirname(__FILE__) + '/market_beat/historical'
require File.dirname(__FILE__) + "/market_beat/version"

module MarketBeat
  # Pre-cache available methods so we could use them within
  # method_missing where respond_to? gives false positives.
  @@methods = { :historical => [ :quotes ] }
  if RUBY_VERSION < '1.9.0'
    @@methods[:yahoo]  = (Yahoo.methods  - Object.methods).map { |m| m.to_sym }
    @@methods[:google] = (Google.methods - Object.methods).map { |m| m.to_sym }
  else
    @@methods[:yahoo]  = Yahoo.methods  - Object.methods
    @@methods[:google] = Google.methods - Object.methods
  end

  # Proxy MarketBeat methods to either Google or Yahoo providers.
  def self.method_missing(method, *args, &blk)
    if @@methods[:google].include?(method)
      Google.send(method, *args)
    elsif @@methods[:yahoo].include?(method)
      Yahoo.send(method, *args)
    elsif @@methods[:historical].include?(method)
      Historical.send(method, *args)
    else
      super
    end
  end

  if RUBY_VERSION > '1.9'
    # Make MarketBeat.respond_to? return true for all the methods above.
    def self.respond_to_missing?(method, include_private)
      super(method, include_private) || @@methods.values.flatten.include?(method)
    end
  end
end
