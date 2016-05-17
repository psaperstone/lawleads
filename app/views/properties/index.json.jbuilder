json.array!(@properties) do |property|
  json.extract! property, :id, :owner, :prop_str_addr, :prop_city, :prop_zip, :assessed_value, :prop_acct_num, :legal_desc, :mail_str_addr, :mail_city, :mail_zip
  json.url property_url(property, format: :json)
end
