
class DeliveryCenterFetcher
  def initialize
    @uri = 'https://delivery-center-recruitment-ap.herokuapp.com/'
    @headers = {
      'Accept' => 'application/json',
      'X-SENT' => Time.now.strftime('%Hh%M - %d/%m/%y')
    }
  end

  def send_order(payload)
    binding.pry
    Faraday.post(@uri, payload, @headers)
  end
  
end
