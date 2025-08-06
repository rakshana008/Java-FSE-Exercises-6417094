import React from 'react';
import CalculateScore from './Components/CalculateScore';

function App() {
  return (
    <div>
      <CalculateScore
        name="Rakshana"
        school="Nandha Engineering College"
        total={480}
        goal={6}
      />
    </div>
  );
}

export default App;
