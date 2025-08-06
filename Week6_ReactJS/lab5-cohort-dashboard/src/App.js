import React from 'react';
import CohortDetails from './CohortDetails';

function App() {
  return (
    <div>
      <CohortDetails name="React Bootcamp" status="ongoing" />
      <CohortDetails name="Java Bootcamp" status="completed" />
    </div>
  );
}

export default App;
