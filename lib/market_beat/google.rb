# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require 'rexml/document'
require 'net/http'
require 'uri'
require 'yaml'

module MarketBeat
  class Google
    URL = 'http://www.google.com/ig/api?stock='.freeze
    REAL_TIME_URL = 'http://finance.google.com/finance/info?client=ig&q='.freeze

    class << self
      metrics = YAML.load_file(File.dirname(__FILE__) + '/google.yml')
      metrics.each do |key, value|
        if value !~ /real_time$/
          define_method value do |ticker|
            from_xml fetch(ticker), key
          end
        else
          define_method value do |ticker|
            from_json fetch(ticker, :real_time), key
          end
        end
      end

      private
      def fetch(ticker, real_time = false)
        uri = URI.parse("#{real_time ? REAL_TIME_URL : URL}#{ticker}")
        response = Net::HTTP.get_response(uri)
        response.body
      end

      def from_xml(xml, metric)
        doc = REXML::Document.new(xml)
        doc.elements["//finance/#{metric}"].attributes['data']
      end

      def from_json(json, metric)
        json =~ /"#{metric}"\s*\:\s*"(.+?)"/ ? $1 : nil
      end
    end
  end
end
