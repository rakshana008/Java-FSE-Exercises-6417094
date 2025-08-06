import React, { useState } from "react";
import BookDetails from "./BookDetails";
import BlogDetails from "./BlogDetails";
import CourseDetails from "./CourseDetails";

function App() {
  const [page, setPage] = useState("book");

  const renderComponent = () => {
    switch (page) {
      case "book":
        return <BookDetails />;
      case "blog":
        return <BlogDetails />;
      case "course":
        return <CourseDetails />;
      default:
        return <h2>Please select a valid view.</h2>;
    }
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Blogger App</h1>

      <div style={{ marginBottom: "20px" }}>
        <button onClick={() => setPage("book")}>Show Book</button>
        <button onClick={() => setPage("blog")}>Show Blog</button>
        <button onClick={() => setPage("course")}>Show Course</button>
      </div>

      {renderComponent()}
    </div>
  );
}

export default App;
