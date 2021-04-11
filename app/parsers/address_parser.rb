# frozen_string_literal: true

class AddressParser
  STATE_OPTIONS = {
    "Acre": 'AC',
    "Alagoas": 'AL',
    "Amapá": 'AP',
    "Amazonas": 'AM',
    "Bahia": 'BA',
    "Ceará": 'CE',
    "Distrito Federal": 'DF',
    "Espírito Santo": 'ES',
    "Goiás": 'GO',
    "Maranhão": 'MA',
    "Mato Grosso": 'MT',
    "Mato Grosso do Sul": 'MS',
    "Minas Gerais": 'MG',
    "Pará": 'PA',
    "Paraíba": 'PB',
    "Paraná": 'PR',
    "Pernambuco": 'PE',
    "Piauí": 'PI',
    "Rio de Janeiro": 'RJ',
    "Rio Grande do Norte": 'RN',
    "Rio Grande do Sul": 'RS',
    "Rondônia": 'RO',
    "Roraima": 'RR',
    "Santa Catarina": 'SC',
    "São Paulo": 'SP',
    "Sergipe": 'SE',
    "Tocantins": 'TO'
  }

  def initialize(params)
    @params = params[:shipping][:receiver_address]
  end

  def parse_address
    {
      country: @params[:country][:id],
      state: AddressParser::STATE_OPTIONS[:"#{@params[:state][:name]}"],
      city: @params[:city][:name],
      district: @params[:neighborhood][:name],
      street: @params[:street_name],
      complement: @params[:comment],
      latitude: @params[:latitude],
      longitude: @params[:longitude],
      postal_code: @params[:zip_code],
      number: @params[:street_number]
    }
  end
end
