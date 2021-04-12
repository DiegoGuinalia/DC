module PayloadData
  def valid_payload
    payload = File.open("#{Dir.pwd}/spec/support/valid_data.json")
    JSON.load(payload)
  end

  def invalid_payload
    payload = File.open("#{Dir.pwd}/spec/support/invalid_data.json")
    JSON.load(payload)
  end
end