import React from "react";

const players = [
  { name: "Player 1", score: 95 },
  { name: "Player 2", score: 45 },
  { name: "Player 3", score: 80 },
  { name: "Player 4", score: 60 },
  { name: "Player 5", score: 90 },
  { name: "Player 6", score: 30 },
  { name: "Player 7", score: 75 },
  { name: "Player 8", score: 85 },
  { name: "Player 9", score: 50 },
  { name: "Player 10", score: 40 },
  { name: "Player 11", score: 70 },
];

const ListofPlayers = () => {
  const filteredPlayers = players.filter((p) => p.score >= 70);

  return (
    <div>
      <h2>Players with Score >= 70</h2>
      {filteredPlayers.map((p, index) => (
        <p key={index}>{p.name} - {p.score}</p>
      ))}
    </div>
  );
};

export default ListofPlayers;
