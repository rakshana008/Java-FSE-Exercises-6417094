import React, { useState } from "react";
import UserPage from "./UserPage";
import GuestPage from "./GuestPage";

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const toggleLogin = () => {
    setIsLoggedIn(!isLoggedIn);
  };

  return (
    <div style={{ padding: "20px", fontFamily: "Arial" }}>
      <h1>✈️ Ticket Booking App</h1>

      <button onClick={toggleLogin}>
        {isLoggedIn ? "Logout" : "Login"}
      </button>

      <hr />

      {isLoggedIn ? <UserPage /> : <GuestPage />}
    </div>
  );
}

export default App;
