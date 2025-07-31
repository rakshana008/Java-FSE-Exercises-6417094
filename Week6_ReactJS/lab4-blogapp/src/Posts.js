import React, { Component } from 'react';

class Posts extends Component {
  constructor(props) {
    super(props);
    this.state = {
      posts: [],
      error: null,
    };
  }

 componentDidMount() {
  const fakePosts = [
    { id: 1, title: "Post One", body: "This is the first post." },
    { id: 2, title: "Post Two", body: "This is the second post." },
    { id: 3, title: "Post Three", body: "This is the third post." },
    { id: 4, title: "Post Four", body: "This is the fourth post." },
    { id: 5, title: "Post Five", body: "This is the fifth post." },
    { id: 6, title: "Post Six", body: "This is the sixth post." },
    { id: 7, title: "Post Seven", body: "This is the seventh post." },
    { id: 8, title: "Post Eight", body: "This is the eighth post." },
    { id: 9, title: "Post Nine", body: "This is the ninth post." },
    { id: 10, title: "Post Ten", body: "This is the tenth post." }
  ];

  this.setState({ posts: fakePosts });
}



  render() {
    const { posts, error } = this.state;

    if (error) {
      return <h2>Error: {error.message}</h2>;
    }

    return (
      <div style={{ padding: '20px' }}>
        <h1>Blog Posts</h1>
        {posts.length === 0 ? (
          <p>Loading posts...</p>
        ) : (
          posts.slice(0, 10).map((post) => (
            <div key={post.id} style={{ marginBottom: '20px' }}>
              <h3>{post.title}</h3>
              <p>{post.body}</p>
              <hr />
            </div>
          ))
        )}
      </div>
    );
  }
}

export default Posts;
