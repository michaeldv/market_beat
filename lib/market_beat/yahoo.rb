# Copyright (c) 2011-12 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require 'net/http'
require 'uri'
require 'yaml'

module MarketBeat
  class Yahoo
    URL = 'http://download.finance.yahoo.com/d/quotes.csv?s='.freeze
    L2N = { 'M' => 1_000_000, 'B' => 1_000_000_000 }.freeze

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
        data = raw.strip.gsub(/\r|\n|"|<\/?b>|&nbsp;/, '')
        min, max = data.split(/\s+\-\s+/)
        min && max ? [scrub(min), scrub(max)] : scrub(min)
      end

      def scrub(data)
        # Convert empty string, '-' or 'N/A' to nil
        return nil if data =~ /^(?:\s*|N\/A|\-)$/
        # Normalize numbers:
        #   '1,234.56'  => '1234.56'
        #   '1,234.56M' => '1234560000'
        #   '1,234.56B' => '1234560000000'
        if data =~ /^[\.\d,]+[MB]*$/
          data.gsub!(',', '')
          data = (data[0..-2].to_f * L2N[data[-1,1]]).to_i.to_s if L2N[data[-1,1]]
        end
        data
      end
    end
  end
end
