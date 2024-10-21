class PokemonsController < ApplicationController
  def index
    pokemons = Pokemon.all
    pokemons = pokemons.where("nombre LIKE ?", "%#{params[:nombre]}%") if params[:nombre].present?
    pokemons = pokemons.where("tipo = ?", params[:tipo]) if params[:tipo].present?

    render json: {
      pokemons: pokemons,
      total_pokemons: pokemons.count
    }
  end
  
  def import
    (1..150).each do |id|
      Pokemon.create(
        nombre: "Pokemon_#{id}",
        tipo: ["agua", "fuego", "tierra", "eléctrico"].sample,
        imagen: "url_de_imagen_#{id}",
        estado_captura: false
      )
    end
    render json: { message: 'Importación completada' }, status: :ok
  end

  def capture
    pokemon = Pokemon.find(params[:id])
    if pokemon.update(estado_captura: true)
      captured_pokemons = Pokemon.where(estado_captura: true)
      if captured_pokemons.count > 6
        oldest_pokemon = captured_pokemons.order(:updated_at).first
        oldest_pokemon.update(estado_captura: false)
      end
      render json: { message: 'Pokémon capturado' }, status: :ok
    else
      render json: { message: 'Error capturando Pokémon' }, status: :unprocessable_entity
    end
  end

  def captured
    pokemons = Pokemon.where(estado_captura: true)
    render json: pokemons
  end


  def destroy
    pokemon = Pokemon.find(params[:id])
    if pokemon.update(estado_captura: false)
    render json: { message: 'Pokémon liberado' }, status: :ok
    else
    render json: { message: 'Error liberando Pokémon' }, status: :unprocessable_entity
    end
  end


end

