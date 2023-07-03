CREATE TABLE images (
   id INT AUTO_INCREMENT PRIMARY KEY,
   url VARCHAR(500) NOT NULL,
   description VARCHAR(500) NOT NULL 
);


-- Insert the cat image URLs
INSERT INTO images (url)
VALUES
  ('https://media.giphy.com/media/yr7n0u3qzO9nG/giphy.gif'),
  ('https://media.tenor.com/rMLswxLq2uEAAAAM/funny-as.gif'),
  ('https://i.gifer.com/QPt.gif'),
  ('https://media1.giphy.com/media/mC7VjtF9sYofs9DUa5/200w.gif?cid=6c09b9521pven9h01wypu84n9jt6eg2q87g01vl3mlkikduj&ep=v1_gifs_search&rid=200w.gif&ct=g'),
  ('https://media0.giphy.com/media/kbuQOkATEo6VW/giphy.gif'),
  ('https://media.tenor.com/lSqAQeWHBQAAAAAC/sid-ice.gif'),
  ('https://thumbs.gfycat.com/CalculatingEcstaticDwarfrabbit-size_restricted.gif'),
  ('https://media1.giphy.com/media/H5C8CevNMbpBqNqFjl/giphy.gif'),
  ('https://media.tenor.com/-o7IJJHaE5MAAAAM/kto-kounotoritoken.gif'),
  ('https://media.giphy.com/media/yr7n0u3qzO9nG/giphy.gif'),
  ('https://media.tenor.com/rMLswxLq2uEAAAAM/funny-as.gif'),
  ('https://media.tenor.com/-o7IJJHaE5MAAAAM/kto-kounotoritoken.gif');

-- Insert the cat image descriptions
INSERT INTO images (description)
VALUES
  ('a'),
  ('a'),
  ('a'),
  ('a'),
  ('a'),
  ('a'),
  ('a');