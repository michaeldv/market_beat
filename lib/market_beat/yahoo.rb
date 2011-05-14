# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require 'net/http'
require 'uri'
require 'yaml'

module MarketBeat
  class Yahoo
    URL = 'http://download.finance.yahoo.com/d/quotes.csv?s='

    class << self
      metrics = YAML.load_file(File.dirname(__FILE__) + '/yahoo.yml')
      metrics.each do |key, value|
        define_method value do |ticker|
          sanitize fetch(ticker, key)
        end
      end

      private
      def fetch(ticker, metric)
        uri = URI.parse("#{URL}#{ticker}&f=#{metric}")
        response = Net::HTTP.get_response(uri)
        response.body
      end

      def sanitize(raw)
        data = raw.gsub(/\r|\n|"|<\/?b>|&nbsp;/, '')
        min, max = data.split(/\s+\-\s+/)
        min && max ? [scrub(min), scrub(max)] : scrub(min)
      end

      def scrub(data)
        data =~ /^(?:\s*|N\/A|\-)$/ ? nil : data
      end
    end
  end
end
