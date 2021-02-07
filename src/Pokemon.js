import React, { useState } from 'react';
import mockData from './mockData';

const Pokemon = (props) => {
  const {
    match: {
      params: { pokemonId },
    },
  } = props;
  const [pokemon, setPokemon] = useState(mockData);

  return <div>{`this is pokemon page for pokemon # ${pokemonId}`}</div>;
};

export default Pokemon;
