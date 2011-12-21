# Copyright (c) 2011 Michael Dvorkin
#
# Market Beat is freely distributable under the terms of MIT license.
# See LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'yaml'

describe "MarketBeat::Yahoo" do
  before(:all) do
    @apple  = YAML.load_file(File.dirname(__FILE__) + '/fixtures/AAPL.yml')
    @google = YAML.load_file(File.dirname(__FILE__) + '/fixtures/GOOG.yml')
  end

  def apple(metric)
    response = mock(:body => @apple[metric])
    Net::HTTP.should_receive(:get_response).once.and_return(response)
    MarketBeat::Yahoo.send(metric, 'AAPL')
  end

  def google(metric)
    response = mock(:body => @google[metric])
    Net::HTTP.should_receive(:get_response).once.and_return(response)
    MarketBeat::Yahoo.send(metric, 'GOOG')
  end

  it 'after_hours_change_real_time' do
     apple(:after_hours_change_real_time).should == [ nil, nil ]
    google(:after_hours_change_real_time).should == [ nil, nil ]
  end

  it 'annualized_gain' do
     apple(:annualized_gain).should == nil
    google(:annualized_gain).should == nil
  end

  it 'ask' do
     apple(:ask).should == '340.50'
    google(:ask).should == '529.98'
  end

  it 'ask_real_time' do
     apple(:ask_real_time).should == '340.50'
    google(:ask_real_time).should == '529.98'
  end

  it 'ask_size' do
     apple(:ask_size).should == '100'
    google(:ask_size).should == '100'
  end

  it 'average_daily_volume' do
     apple(:average_daily_volume).should == '16464000'
    google(:average_daily_volume).should == '2773170'
  end

  it 'bid' do
     apple(:bid).should == '340.23'
    google(:bid).should == nil
  end

  it 'bid_real_time' do
     apple(:bid_real_time).should == '340.23'
    google(:bid_real_time).should == '0.00'
  end

  it 'bid_size' do
     apple(:bid_size).should == '200'
    google(:bid_size).should == nil
  end

  it 'book_value' do
     apple(:book_value).should == '66.485'
    google(:book_value).should == '153.49'
  end

  it 'change' do
     apple(:change).should == '-6.07'
    google(:change).should == '-5.50'
  end

  it 'change_and_percent_change' do
     apple(:change_and_percent_change).should == [ '-6.07', '-1.75%' ]
    google(:change_and_percent_change).should == [ '-5.50', '-1.03%' ]
  end

  it 'change_from_200_day_moving_average' do
     apple(:change_from_200_day_moving_average).should == '+5.811'
    google(:change_from_200_day_moving_average).should == '-60.526'
  end

  it 'change_from_50_day_moving_average' do
     apple(:change_from_50_day_moving_average).should == '-3.171'
    google(:change_from_50_day_moving_average).should == '-24.389'
  end

  it 'change_from_52_week_high' do
     apple(:change_from_52_week_high).should == '-24.40'
    google(:change_from_52_week_high).should == '-113.41'
  end

  it 'change_from_52_week_low' do
     apple(:change_from_52_week_low).should == '+109.15'
    google(:change_from_52_week_low).should == '+95.92'
  end

  it 'percent_change' do
     apple(:percent_change).should == '-1.75%'
    google(:percent_change).should == '-1.03%'
  end

  it 'change_percent_real_time' do
     apple(:change_percent_real_time).should == [ nil, '-1.75%' ]
    google(:change_percent_real_time).should == [ nil, '-1.03%' ]
  end

  it 'change_real_time' do
     apple(:change_real_time).should == '-6.07'
    google(:change_real_time).should == '-5.50'
  end

  it 'commission' do
     apple(:commission).should == nil
    google(:commission).should == nil
  end

  it 'days_high' do
     apple(:days_high).should == '346.25'
    google(:days_high).should == '535.92'
  end

  it 'days_low' do
     apple(:days_low).should == '340.35'
    google(:days_low).should == '529.05'
  end

  it 'days_range' do
     apple(:days_range).should == [ '340.35', '346.25' ]
    google(:days_range).should == [ '529.05', '535.92' ]
  end

  it 'days_range_real_time' do
     apple(:days_range_real_time).should == [ nil, nil ]
    google(:days_range_real_time).should == [ nil, nil ]
  end

  it 'days_value_change' do
     apple(:days_value_change).should == [ nil, '-1.75%' ]
    google(:days_value_change).should == [ nil, '-1.03%' ]
  end

  it 'days_value_change_real_time' do
     apple(:days_value_change_real_time).should == [ nil, nil ]
    google(:days_value_change_real_time).should == [ nil, nil ]
  end

  it 'dividend_pay_date' do
     apple(:dividend_pay_date).should == nil
    google(:dividend_pay_date).should == nil
  end

  it 'dividend_to_share' do
     apple(:dividend_to_share).should == '0.00'
    google(:dividend_to_share).should == '0.00'
  end

  it 'dividend_yield' do
     apple(:dividend_yield).should == nil
    google(:dividend_yield).should == nil
  end

  it 'earnings_to_share' do
     apple(:earnings_to_share).should == '20.992'
    google(:earnings_to_share).should == '27.291'
  end

  it 'ebitda' do
     apple(:ebitda).should == '26726000000' # '26.726B'
    google(:ebitda).should == '12155000000' # '12.155B'
  end

  it 'eps_estimate_current_year' do
     apple(:eps_estimate_current_year).should == '24.63'
    google(:eps_estimate_current_year).should == '33.94'
  end

  it 'eps_estimate_next_quarter' do
     apple(:eps_estimate_next_quarter).should == '6.36'
    google(:eps_estimate_next_quarter).should == '8.31'
  end

  it 'eps_estimate_next_year' do
     apple(:eps_estimate_next_year).should == '28.51'
    google(:eps_estimate_next_year).should == '39.55'
  end

  it 'error_indication' do
     apple(:error_indication).should == nil
    google(:error_indication).should == nil
  end

  it 'ex_dividend_date' do
     apple(:ex_dividend_date).should == '21-Nov-95'
    google(:ex_dividend_date).should == nil
  end

  it 'float_shares' do
     apple(:float_shares).should == '918706000'
    google(:float_shares).should == '251385000'
  end

  it 'high_52_week' do
     apple(:high_52_week).should == '364.90'
    google(:high_52_week).should == '642.96'
  end

  it 'high_limit' do
     apple(:high_limit).should == nil
    google(:high_limit).should == nil
  end

  it 'holdings_gain' do
     apple(:holdings_gain).should == nil
    google(:holdings_gain).should == nil
  end

  it 'holdings_gain_percent' do
     apple(:holdings_gain_percent).should == [ nil, nil ]
    google(:holdings_gain_percent).should == [ nil, nil ]
  end

  it 'holdings_gain_percent_real_time' do
     apple(:holdings_gain_percent_real_time).should == [ nil, nil ]
    google(:holdings_gain_percent_real_time).should == [ nil, nil ]
  end

  it 'holdings_gain_real_time' do
     apple(:holdings_gain_real_time).should == nil
    google(:holdings_gain_real_time).should == nil
  end

  it 'holdings_value' do
     apple(:holdings_value).should == nil
    google(:holdings_value).should == nil
  end

  it 'holdings_value_real_time' do
     apple(:holdings_value_real_time).should == nil
    google(:holdings_value_real_time).should == nil
  end

  it 'last_trade_date' do
     apple(:last_trade_date).should == '5/13/2011'
    google(:last_trade_date).should == '5/13/2011'
  end

  it 'last_trade_price_only' do
     apple(:last_trade).should == '340.50'
    google(:last_trade).should == '529.55'
  end

  it 'last_trade_real_time_with_time' do
     apple(:last_trade_real_time_with_time).should == [ nil, '340.50' ]
    google(:last_trade_real_time_with_time).should == [ nil, '529.55' ]
  end

  it 'last_trade_size' do
     apple(:last_trade_size).should == '3570'
    google(:last_trade_size).should == '980'
  end

  it 'last_trade_time' do
     apple(:last_trade_time).should == '4:00pm'
    google(:last_trade_time).should == '4:00pm'
  end

  it 'last_trade_with_time' do
     apple(:last_trade_with_time).should == [ 'May 13', '340.50' ]
    google(:last_trade_with_time).should == [ 'May 13', '529.55' ]
  end

  it 'low_52_week' do
     apple(:low_52_week).should == '231.35'
    google(:low_52_week).should == '433.63'
  end

  it 'low_limit' do
     apple(:low_limit).should == nil
    google(:low_limit).should == nil
  end

  it 'market_cap_real_time' do
     apple(:market_cap_real_time).should == nil
    google(:market_cap_real_time).should == nil
  end

  it 'market_capitalization' do
     apple(:market_capitalization).should == '314900000000' # '314.9B'
    google(:market_capitalization).should == '170300000000' # '170.3B'
  end

  it 'more_info' do
     apple(:more_info).should == 'cnsprmiIed'
    google(:more_info).should == 'cnprmiIed'
  end

  it 'moving_average_200_day' do
     apple(:moving_average_200_day).should == '334.689'
    google(:moving_average_200_day).should == '590.076'
  end

  it 'moving_average_50_day' do
     apple(:moving_average_50_day).should == '343.671'
    google(:moving_average_50_day).should == '553.939'
  end

  it 'company' do
     apple(:company).should == 'Apple Inc.'
    google(:company).should == 'Google Inc.'
  end

  it 'notes' do
     apple(:notes).should == nil
    google(:notes).should == nil
  end

  it 'one_year_target_price' do
     apple(:one_year_target_price).should == '446.87'
    google(:one_year_target_price).should == '701.54'
  end

  it 'opening_price' do
     apple(:opening_price).should == '345.79'
    google(:opening_price).should == '534.51'
  end

  it 'order_book_real_time' do
     apple(:order_book_real_time).should == nil
    google(:order_book_real_time).should == nil
  end

  it 'pe_ratio' do
     apple(:pe_ratio).should == '16.51'
    google(:pe_ratio).should == '19.61'
  end

  it 'pe_ratio_real_time' do
     apple(:pe_ratio_real_time).should == nil
    google(:pe_ratio_real_time).should == nil
  end

  it 'peg_ratio' do
     apple(:peg_ratio).should == '0.67'
    google(:peg_ratio).should == '0.89'
  end

  it 'percent_change_from_200_day_moving_average' do
     apple(:percent_change_from_200_day_moving_average).should == '+1.74%'
    google(:percent_change_from_200_day_moving_average).should == '-10.26%'
  end

  it 'percent_change_from_50_day_moving_average' do
     apple(:percent_change_from_50_day_moving_average).should == '-0.92%'
    google(:percent_change_from_50_day_moving_average).should == '-4.40%'
  end

  it 'percent_change_from_52_week_high' do
     apple(:percent_change_from_52_week_high).should == '-6.69%'
    google(:percent_change_from_52_week_high).should == '-17.64%'
  end

  it 'percent_change_from_52_week_low' do
     apple(:percent_change_from_52_week_low).should == '+47.18%'
    google(:percent_change_from_52_week_low).should == '+22.12%'
  end

  it 'previous_close' do
     apple(:previous_close).should == '346.57'
    google(:previous_close).should == '535.05'
  end

  it 'price_paid' do
     apple(:price_paid).should == nil
    google(:price_paid).should == nil
  end

  it 'price_to_book' do
     apple(:price_to_book).should == '5.21'
    google(:price_to_book).should == '3.49'
  end

  it 'price_to_eps_estimate_current_year' do
     apple(:price_to_eps_estimate_current_year).should == '14.07'
    google(:price_to_eps_estimate_current_year).should == '15.76'
  end

  it 'price_to_eps_estimate_next_year' do
     apple(:price_to_eps_estimate_next_year).should == '12.16'
    google(:price_to_eps_estimate_next_year).should == '13.53'
  end

  it 'price_to_sales' do
     apple(:price_to_sales).should == '3.66'
    google(:price_to_sales).should == '5.53'
  end

  it 'range_52_week' do
     apple(:range_52_week).should == [ '231.35', '364.90' ]
    google(:range_52_week).should == [ '433.63', '642.96' ]
  end

  it 'shares_owned' do
     apple(:shares_owned).should == nil
    google(:shares_owned).should == nil
  end

  it 'short_ratio' do
     apple(:short_ratio).should == '0.80'
    google(:short_ratio).should == '1.20'
  end

  it 'stock_exchange' do
     apple(:stock_exchange).should == 'NasdaqNM'
    google(:stock_exchange).should == 'NasdaqNM'
  end

  it 'symbol' do
     apple(:symbol).should == 'AAPL'
    google(:symbol).should == 'GOOG'
  end

  it 'ticker_trend' do
     apple(:ticker_trend).should == '======'
    google(:ticker_trend).should == '======'
  end

  it 'trade_date' do
     apple(:trade_date).should == nil
    google(:trade_date).should == nil
  end

  it 'volume' do
     apple(:volume).should == '11649708'
    google(:volume).should == '2107641'
  end
end
