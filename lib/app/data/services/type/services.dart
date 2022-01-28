import 'package:flutter/material.dart';
import 'package:pokedex/app/core/values/type_colors.dart';

class TypeColor {
  static Color get(PokemonType pokemonType) {
    switch (pokemonType) {
      case PokemonType.bug:
        return bug;
      case PokemonType.dark:
        return dark;
      case PokemonType.dragon:
        return dragon;
      case PokemonType.electric:
        return electric;
      case PokemonType.fairy:
        return fairy;
      case PokemonType.fighting:
        return fighting;
      case PokemonType.fire:
        return fire;
      case PokemonType.flying:
        return flying;
      case PokemonType.ghost:
        return ghost;
      case PokemonType.grass:
        return grass;
      case PokemonType.ground:
        return ground;
      case PokemonType.ice:
        return ice;
      case PokemonType.normal:
        return normal;
      case PokemonType.poison:
        return poison;
      case PokemonType.psychic:
        return psychic;
      case PokemonType.rock:
        return rock;
      case PokemonType.steel:
        return steel;
      default:
        return water;
    }
  }
}

class Type {
  static PokemonType get(String type) {
    switch (type) {
      case 'bug':
        return PokemonType.bug;
      case 'dark':
        return PokemonType.dark;
      case 'dragon':
        return PokemonType.dragon;
      case 'electric':
        return PokemonType.electric;
      case 'fairy':
        return PokemonType.fairy;
      case 'fighting':
        return PokemonType.fighting;
      case 'fire':
        return PokemonType.fire;
      case 'flying':
        return PokemonType.flying;
      case 'ghost':
        return PokemonType.ghost;
      case 'grass':
        return PokemonType.grass;
      case 'ground':
        return PokemonType.ground;
      case 'ice':
        return PokemonType.ice;
      case 'normal':
        return PokemonType.normal;
      case 'poison':
        return PokemonType.poison;
      case 'psychic':
        return PokemonType.psychic;
      case 'rock':
        return PokemonType.rock;

      case 'steel':
        return PokemonType.steel;
      default:
        return PokemonType.water;
    }
  }
}
