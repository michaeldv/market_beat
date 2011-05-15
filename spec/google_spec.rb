require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MarketBeat::Google Delayed" do
  before(:all) do
    @ibm = File.read(File.dirname(__FILE__) + '/fixtures/IBM.xml')
  end

  def ibm(metric)
    response = mock(:body => @ibm)
    Net::HTTP.should_receive(:get_response).once.and_return(response)
    MarketBeat::Google.send(metric, :ibm)
  end

  it "average_daily_volume" do
    ibm(:average_daily_volume).should == '5084'
  end

  it "brut_last" do
    ibm(:brut_last).should == nil
  end

  it "brut_trade_date_utc" do
    ibm(:brut_trade_date_utc).should == nil
  end

  it "brut_trade_time_utc" do
    ibm(:brut_trade_time_utc).should == nil
  end

  it "change" do
    ibm(:change).should == '-2.32'
  end

  it "chart_url" do
    ibm(:chart_url).should == '/finance/chart?q=NYSE:IBM&tlf=12'
  end

  it "currency" do
    ibm(:currency).should == 'USD'
  end

  it "current_date_utc" do
    ibm(:current_date_utc).should == '20110515'
  end

  it "current_time_utc" do
    ibm(:current_time_utc).should == '001456'
  end

  it "daylight_savings" do
    ibm(:daylight_savings).should == 'true'
  end

  it "days_high" do
    ibm(:days_high).should == '172.15'
  end

  it "days_low" do
    ibm(:days_low).should == '169.44'
  end

  it "delay" do
    ibm(:delay).should == '0'
  end

  it "disclaimer_url" do
    ibm(:disclaimer_url).should == '/help/stock_disclaimer.html'
  end

  it "divisor" do
    ibm(:divisor).should == '2'
  end

  it "ecn_url" do
    ibm(:ecn_url).should == nil
  end

  it "isld_last" do
    ibm(:isld_last).should == nil
  end

  it "isld_trade_date_utc" do
    ibm(:isld_trade_date_utc).should == nil
  end

  it "isld_trade_time_utc" do
    ibm(:isld_trade_time_utc).should == nil
  end

  it "last_trade" do
    ibm(:last_trade).should == '169.92'
  end

  it "market_capitalization" do
    ibm(:market_capitalization).should == '207223.55'
  end

  it "name" do
    ibm(:name).should == 'International Business Machines Corp.'
  end

  it "open" do
    ibm(:open).should == '171.70'
  end

  it "percent_change" do
    ibm(:percent_change).should == '-1.35'
  end

  it "pretty_symbol" do
    ibm(:pretty_symbol).should == 'IBM'
  end

  it "previous_close" do
    ibm(:previous_close).should == '172.24'
  end

  it "stock_exchange" do
    ibm(:stock_exchange).should == 'NYSE'
  end

  it "stock_exchange_closing" do
    ibm(:stock_exchange_closing).should == '960'
  end

  it "stock_exchange_timezone" do
    ibm(:stock_exchange_timezone).should == 'ET'
  end

  it "stock_exchange_utc_offset" do
    ibm(:stock_exchange_utc_offset).should == '+05:00'
  end

  it "symbol" do
    ibm(:symbol).should == 'IBM'
  end

  it "symbol_lookup_url" do
    ibm(:symbol_lookup_url).should == '/finance?client=ig&q=IBM'
  end

  it "symbol_url" do
    ibm(:symbol_url).should == '/finance?client=ig&q=IBM'
  end

  it "trade_date_utc" do
    ibm(:trade_date_utc).should == '20110513'
  end

  it "trade_time_utc" do
    ibm(:trade_time_utc).should == '200138'
  end

  it "trade_timestamp" do
    ibm(:trade_timestamp).should == 'May 13, 2011'
  end

  it "volume" do
    ibm(:volume).should == '5168995'
  end
end

describe "MarketBeat::Google Real Time" do
  before(:all) do
    @citibank = File.read(File.dirname(__FILE__) + '/fixtures/C.json')
  end

  def citibank(metric)
    response = mock(:body => @citibank)
    Net::HTTP.should_receive(:get_response).once.and_return(response)
    MarketBeat::Google.send(metric, :c)
  end

  it "change_real_time" do
    citibank(:change_real_time).should == '-0.89'
  end

  it "color_code" do
    citibank(:color_code_real_time).should == 'chr'
  end

  it "last_trade_datetime_real_time" do
    citibank(:last_trade_datetime_real_time).should == 'May 13, 4:00PM EDT'
  end

  it "last_trade_real_time" do
    citibank(:last_trade_real_time).should == '41.53'
  end

  it "last_trade_time_real_time" do
    citibank(:last_trade_time_real_time).should == '4:00PM EDT'
  end

  it "percent_change_real_time" do
    citibank(:percent_change_real_time).should == '-2.10'
  end
end
