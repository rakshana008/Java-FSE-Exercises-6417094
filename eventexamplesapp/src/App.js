import React, { useState } from "react";
import CurrencyConvertor from "./CurrencyConvertor";

function App() {
  const [count, setCount] = useState(0);

  // Multiple methods for button click
  const sayHello = () => {
    console.log("Hello!");
    alert("Hello from React!");
  };

  const increment = () => {
    setCount(count + 1);
    sayHello();
  };

  // Function with parameter
  const sayWelcome = (msg) => {
    alert(msg);
  };

  // Synthetic event
  const handleClick = (e) => {
    alert("I was clicked (Synthetic Event)");
    console.log("Event type:", e.type);
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>React Event Examples</h1>

      <h2>Counter: {count}</h2>
      <button onClick={increment}>Increment</button>
      <button onClick={() => setCount(count - 1)}>Decrement</button>

      <hr />

      <button onClick={() => sayWelcome("Welcome to React!")}>
        Say Welcome
      </button>

      <hr />

      <button onClick={handleClick}>Click Me (Synthetic Event)</button>

      <hr />

      <CurrencyConvertor />
    </div>
  );
}

export default App;
