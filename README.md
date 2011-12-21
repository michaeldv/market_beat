## MarketBeat ##
Market Beat is a Ruby library that fetches stock quotes and other financial
and market indicators from publicly available sources. Currently Google and
Yahoo market reporting services are supported.

### Installation ###
    # Installing as Ruby gem
    $ gem install market_beat

    # Cloning the repository
    $ git clone git://github.com/michaeldv/market_beat.git

### Usage ###
Require "market_beat" gem, then invoke one of the MarketBeat's methods passing
stock symbol as a parameter. Stock symbols are case insensitive and could be
passed as a symbol or a string.

For example, to fetch today's opening price and the very latest trade price
for the Apple stock (NASDAQ symbol 'AAPL') use the following:

    >> require "market_beat"
    >> MarketBeat.opening_price :AAPL
    "396.69"
    >> MarketBeat.last_trade_real_time :AAPL
    "397.07"

Some methods return multiple values:

    >> MarketBeat.change_and_percent_change :IBM
    ["-5.77", "-3.08%"]
    >> MarketBeat.last_trade_with_time :IBM
    ["4:02pm", "181.47"]

### Available Methods (Real Time Data) ###

    MarketBeat.after_hours_change_real_time
    MarketBeat.ask_real_time
    MarketBeat.bid_real_time
    MarketBeat.change_percent_real_time
    MarketBeat.change_real_time
    MarketBeat.color_code_real_time
    MarketBeat.days_range_real_time
    MarketBeat.days_value_change_real_time
    MarketBeat.holdings_gain_percent_real_time
    MarketBeat.holdings_gain_real_time
    MarketBeat.holdings_value_real_time
    MarketBeat.last_trade_datetime_real_time
    MarketBeat.last_trade_real_time
    MarketBeat.last_trade_real_time_with_time
    MarketBeat.last_trade_time_real_time
    MarketBeat.market_cap_real_time
    MarketBeat.order_book_real_time
    MarketBeat.pe_ratio_real_time
    MarketBeat.percent_change_real_time

### Available Methods (Delayed Data) ###

    MarketBeat.annualized_gain
    MarketBeat.ask
    MarketBeat.ask_size
    MarketBeat.average_daily_volume
    MarketBeat.bid
    MarketBeat.bid_size
    MarketBeat.book_value
    MarketBeat.brut_last
    MarketBeat.brut_trade_date_utc
    MarketBeat.brut_trade_time_utc
    MarketBeat.change
    MarketBeat.change_and_percent_change
    MarketBeat.change_from_200_day_moving_average
    MarketBeat.change_from_50_day_moving_average
    MarketBeat.change_from_52_week_high
    MarketBeat.change_from_52_week_low
    MarketBeat.chart_url
    MarketBeat.commission
    MarketBeat.company
    MarketBeat.currency
    MarketBeat.current_date_utc
    MarketBeat.current_time_utc
    MarketBeat.daylight_savings
    MarketBeat.days_high
    MarketBeat.days_low
    MarketBeat.days_range
    MarketBeat.days_value_change
    MarketBeat.delay
    MarketBeat.disclaimer_url
    MarketBeat.dividend_pay_date
    MarketBeat.dividend_to_share
    MarketBeat.dividend_yield
    MarketBeat.divisor
    MarketBeat.earnings_to_share
    MarketBeat.ebitda
    MarketBeat.ecn_url
    MarketBeat.eps_estimate_current_year
    MarketBeat.eps_estimate_next_quarter
    MarketBeat.eps_estimate_next_year
    MarketBeat.error_indication
    MarketBeat.ex_dividend_date
    MarketBeat.float_shares
    MarketBeat.high_52_week
    MarketBeat.high_limit
    MarketBeat.holdings_gain
    MarketBeat.holdings_gain_percent
    MarketBeat.holdings_value
    MarketBeat.isld_last
    MarketBeat.isld_trade_date_utc
    MarketBeat.isld_trade_time_utc
    MarketBeat.last_trade
    MarketBeat.last_trade_date
    MarketBeat.last_trade_size
    MarketBeat.last_trade_time
    MarketBeat.last_trade_with_time
    MarketBeat.low_52_week
    MarketBeat.low_limit
    MarketBeat.market_capitalization
    MarketBeat.more_info
    MarketBeat.moving_average_200_day
    MarketBeat.moving_average_50_day
    MarketBeat.notes
    MarketBeat.one_year_target_price
    MarketBeat.opening_price
    MarketBeat.pe_ratio
    MarketBeat.peg_ratio
    MarketBeat.percent_change
    MarketBeat.percent_change_from_200_day_moving_average
    MarketBeat.percent_change_from_50_day_moving_average
    MarketBeat.percent_change_from_52_week_high
    MarketBeat.percent_change_from_52_week_low
    MarketBeat.pretty_symbol
    MarketBeat.previous_close
    MarketBeat.price_paid
    MarketBeat.price_to_book
    MarketBeat.price_to_eps_estimate_current_year
    MarketBeat.price_to_eps_estimate_next_year
    MarketBeat.price_to_sales
    MarketBeat.range_52_week
    MarketBeat.shares_owned
    MarketBeat.short_ratio
    MarketBeat.stock_exchange
    MarketBeat.stock_exchange_closing
    MarketBeat.stock_exchange_timezone
    MarketBeat.stock_exchange_utc_offset
    MarketBeat.symbol
    MarketBeat.symbol_lookup_url
    MarketBeat.symbol_url
    MarketBeat.ticker_trend
    MarketBeat.trade_date
    MarketBeat.trade_date_utc
    MarketBeat.trade_time_utc
    MarketBeat.trade_timestamp
    MarketBeat.volume

### Running Specs ###

    $ gem install rspec           # RSpec 2.x is the requirement.
    $ rake spec                   # Run the entire spec suite.
    $ rspec spec/google_spec.rb   # Run individual spec file.

### Note on Patches/Pull Requests ###
* Fork the project on Github.
* Make your feature addition or bug fix.
* Add specs for it, making sure $ rake spec is all green.
* Commit, do not mess with Rakefile, version, or history.
* Send me a pull request.

### License ###
Copyright (c) 2011 Michael Dvorkin

twitter.com/mid

%w(mike dvorkin.net) * "@" || %w(mike fatfreecrm.com) * "@"

Released under the MIT license. See LICENSE file for details.
