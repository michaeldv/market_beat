# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.dirname(__FILE__) + '/market_beat/yahoo'
require File.dirname(__FILE__) + '/market_beat/google'
require File.dirname(__FILE__) + "/market_beat/version"

module MarketBeat
  # Pre-cache available methods so we could use them within
  # method_missing where respond_to? gives false positives.
  if RUBY_VERSION < '1.9.0'
    @@yahoo  = (Yahoo.methods  - Object.methods).map { |m| m.to_sym }
    @@google = (Google.methods - Object.methods).map { |m| m.to_sym }
  else
    @@yahoo  = Yahoo.methods  - Object.methods
    @@google = Google.methods - Object.methods
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
