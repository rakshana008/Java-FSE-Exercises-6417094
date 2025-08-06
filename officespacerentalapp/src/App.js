import React from "react";

const App = () => {
  const officeList = [
    { name: "Office A", rent: 55000, address: "Chennai" },
    { name: "Office B", rent: 75000, address: "Bangalore" },
    { name: "Office C", rent: 60000, address: "Hyderabad" },
  ];

  return (
    <div style={{ padding: "20px" }}>
      <h1>Office Space Rental</h1>
      <img src="https://via.placeholder.com/300x150" alt="office" />
      <h2>Office List</h2>
      {officeList.map((office, index) => (
        <div key={index} style={{ border: "1px solid gray", margin: "10px", padding: "10px" }}>
          <p><strong>Name:</strong> {office.name}</p>
          <p style={{ color: office.rent > 60000 ? "green" : "red" }}>
            <strong>Rent:</strong> ₹{office.rent}
          </p>
          <p><strong>Address:</strong> {office.address}</p>
        </div>
      ))}
    </div>
  );
};

export default App;
