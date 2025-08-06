import React, { useState } from "react";

function CurrencyConvertor() {
  const [rupees, setRupees] = useState("");
  const [euro, setEuro] = useState("");

  const handleSubmit = () => {
    const rate = 0.011;
    const converted = (parseFloat(rupees) * rate).toFixed(2);
    setEuro(converted);
  };

  return (
    <div style={{ marginTop: "20px" }}>
      <h3>Currency Converter (INR to EURO)</h3>
      <input
        type="number"
        value={rupees}
        onChange={(e) => setRupees(e.target.value)}
        placeholder="Enter INR"
      />
      <button onClick={handleSubmit}>Convert</button>
      <p>Converted Value: €{euro}</p>
    </div>
  );
}

export default CurrencyConvertor;
