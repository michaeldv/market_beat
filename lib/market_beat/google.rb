# Copyright (c) 2011-12 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require 'rexml/document'
require 'net/http'
require 'uri'
require 'yaml'
require 'thread'

module MarketBeat
  class Google
    BASE_URL  = 'http://www.google.com'.freeze
    QUERY     = '/ig/api?stock='.freeze
    URL       = "#{BASE_URL}#{QUERY}".freeze
    REAL_TIME_URL = 'http://finance.google.com/finance/info?client=ig&q='.freeze

    class << self
      metrics = YAML.load_file(File.dirname(__FILE__) + '/google.yml')
      metrics.each do |key, value|
        if value.to_s !~ /real_time$/
          define_method value do |ticker|
            from_xml fetch(ticker), key
          end
        else
          define_method value do |ticker|
            from_json fetch(ticker, :real_time), key
          end
        end
      end
      @@mutex = Mutex.new
      @@retries = [1, 1, 2, 2, 3]
      @@uri = URI(BASE_URL)
      @@httpl = ->(uri){return Net::HTTP.get_response(uri)}

      def set_proxy(address, port)
        @@httpl = ->(uri){return Net::HTTP::Proxy(@@proxy_address, @@proxy_port).get_response(uri)}
      end

      private
      def fetch(ticker, real_time = false)
        uri = URI.parse("#{real_time ? REAL_TIME_URL : URL}#{ticker}")
        begin
          response = @@httpl.call(uri)
          #returning empty string for. Should improve return for sanitize
          response.is_a?(Net::HTTPSuccess) ? response.body : ""
        rescue Exception => e # I'm too lazy to look it up
          if delay = retry_connect # will be nil if the list is empty
            puts "Failed while connecting to beat source. Retrying."
            sleep delay
            retry # backs up to just after the "begin"
          else
            #should exit with raise or try trought infinity and keep up?
            #Keep going for now leaving a message and rebuilding @@retries
            puts "Can't Connect"
            return ""
          end
        end
      end

      def from_xml(xml, metric)
        doc = REXML::Document.new(xml)
        data = doc.elements["//finance/#{metric}"].attributes['data']
        data.empty? ? nil : data
      end

      def from_json(json, metric)
        json =~ /"#{metric}"\s*\:\s*"(.+?)"/ ? $1 : nil
      end
      
      def retry_connect
        @@mutex.synchronize do
          d = @@retries.shift
          @@retries = [1, 1, 2, 2, 3] if !d
          return d
        end
      end
    end
  end
end
