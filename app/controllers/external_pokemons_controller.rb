require 'net/http'
require 'json'

class ExternalPokemonsController < ApplicationController
  def index
    url = URI.parse('http://localhost:3000/pokemons')
    uri = URI(url)
    response = Net::HTTP.get(url)
    @pokemons = JSON.parse(response)

    render json: @pokemons
  end

  def captured
    url = URI.parse('http://localhost:3000/pokemons/captured')
    uri = URI(url)
    response = Net::HTTP.get(url)
    @captured_pokemons = JSON.parse(response)

    render json: @captured_pokemons
  end
end

