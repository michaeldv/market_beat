# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require 'net/http'
require 'uri'
require 'yaml'
require 'thread'

module MarketBeat
  class Yahoo

    BASE_URL  = 'http://download.finance.yahoo.com'.freeze
    QUERY     = '/d/quotes.csv?s='.freeze
    URL       = "#{BASE_URL}#{QUERY}".freeze
    L2N       = { 'M' => 1_000_000, 'B' => 1_000_000_000 }.freeze

    class << self
      metrics = YAML.load_file(File.dirname(__FILE__) + '/yahoo.yml')
      metrics.each do |key, value|
        define_method value do |ticker|
          sanitize fetch(ticker, key)
        end
      end
      #global retry counter
      @@mutex = Mutex.new
      @@retries = [1, 1, 2, 2, 3]
      @@uri = URI(BASE_URL)
      @@httpl = ->(uri){return Net::HTTP.get_response(uri)}

      def set_proxy(address, port)
        #probably these class variables aren't really necessaire
        @@proxy_address = address
        @@proxy_port    = port
        @@httpl = ->(uri){return Net::HTTP::Proxy(@@proxy_address, @@proxy_port).get_response(uri)}
      end

      private
      def fetch(ticker, metric)
        uri = nil
        #If ticker symbol has a '_' then one assumes that we are looking for a currency pair.
        if ("#{ticker}" =~ /(\w+)_(\w+)$/)
          uri   = URI.parse("#{URL}#{$1}#{$2}=X&f=#{metric}")
        else
          uri   = URI.parse("#{URL}#{ticker}&f=#{metric}")
        end

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
            #raise # with no args re-raises original error
            puts "Can't Connect"
            return ""
          end
        end

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
      
      def retry_connect
        @@mutex.synchronize do
          d = nil
          (d = @@retries.shift) ? d : (@@retries = [1, 1, 2, 2, 3]; d)
        end
      end
      
    end
  end
end
