# Copyright (c) 2011-12 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require "csv"
require "date"

module MarketBeat
  class Historical
    URL = "http://www.google.com/finance/historical?q=%s&startdate=%s&enddate=%s&output=csv"

    class << self
      private
      #
      # Fetch historical quotes. Return nil on error or an array of hashes
      # representing stock data. Empty array means no data is available.
      # Start and end date parameters should be either YYYY-MM-DD strings
      # or Date objects.
      #
      def quotes(ticker, start_date, end_date = Date.today)
        csv = fetch(ticker, start_date, end_date)
        return nil unless csv

        quotes = CSV.parse(csv)     # Parse comma-delimited data.
        quotes[1..-1].map do |col|  # Skip header line.
          #
          # I guess Google finance folks are tight on data so they return year
          # as two digits, ex: 23-Dec-11 or Apr-26-99. With the tweak below we
          # should be good till year 2042 ;-)
          #
          date = *col[0].split("-")
          date[2] = ((date[2] <= "42" ? "20" : "19") + date[2]) if date[2].size == 2
          { :date   => Date.parse(date.join("-")),
            :open   => col[1],
            :high   => col[2],
            :low    => col[3],
            :close  => col[4],
            :volume => col[5]
          }
        end
      end
      #
      # Format the URL and fetch stock data.
      #
      def fetch(ticker, start_date, end_date)
        uri = URI.parse(URL % [ ticker, start_date.to_s, end_date.to_s ])
        response = Net::HTTP.get_response(uri)
        response.body
      rescue Exception => e
        $stderr.puts "market_beat: error fetching quotes\n#{e.inspect}"
        nil
      end
    end
  end
end
