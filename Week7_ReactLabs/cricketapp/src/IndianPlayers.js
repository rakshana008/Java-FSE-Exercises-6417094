import React from "react";

const IndianPlayers = () => {
  const T20players = ["Kohli", "Rohit", "Gill"];
  const RanjiTrophy = ["Pujara", "Rahane", "Karun"];

  const allPlayers = [...T20players, ...RanjiTrophy];
  const [first, second, ...rest] = allPlayers;

  return (
    <div>
      <h2>All Players (Merged)</h2>
      <p>Odd Team Player: {first}</p>
      <p>Even Team Player: {second}</p>
      {rest.map((p, i) => (
        <p key={i}>{p}</p>
      ))}
    </div>
  );
};

export default IndianPlayers;
