const express = require("express");
const mysql = require("mysql2");
const app = express();
const port = 3000;

// Create a MySQL connection
const pool = mysql.createPool({
  host: 'srv1037.hstgr.io',
  user: 'u847678954_JrIFV',
  password: '1AlCSFM65c',
  database: 'u847678954_fPIlC',
});

// Middleware to parse JSON requests
app.use(express.json());

// Define your API endpoints and routes here
app.get('/api/products', (req, res) => {
  // Execute the SQL query to retrieve product details
  const sqlQuery = `
    SELECT
      p.ID AS product_id,
      p.post_title AS product_title,
      p.post_content AS product_description,
      pm1.meta_value AS product_price,
      pm2.meta_value AS product_stock_quantity,
      t.name AS product_category,
      MAX(pm3.meta_value) AS product_rating,
      (
        SELECT GUID
        FROM wp_posts AS pi
        WHERE pi.post_parent = p.ID
        AND pi.post_type = 'attachment'
        LIMIT 1
      ) AS product_image_url
    FROM
      wp_posts AS p
    INNER JOIN
      wp_postmeta AS pm1 ON p.ID = pm1.post_id AND pm1.meta_key = '_price'
    INNER JOIN
      wp_postmeta AS pm2 ON p.ID = pm2.post_id AND pm2.meta_key = '_stock'
    INNER JOIN
      wp_term_relationships AS tr ON p.ID = tr.object_id
    INNER JOIN
      wp_term_taxonomy AS tt ON tr.term_taxonomy_id = tt.term_taxonomy_id
    INNER JOIN
      wp_terms AS t ON tt.term_id = t.term_id AND tt.taxonomy = 'product_cat'
    LEFT JOIN
      wp_postmeta AS pm3 ON p.ID = pm3.post_id AND pm3.meta_key = '_wc_average_rating'
    WHERE
      p.post_type = 'product'
    GROUP BY
      p.ID
    ORDER BY
      p.ID;
  `;

  // Execute the modified SQL query
  pool.query(sqlQuery, (err, results) => {
    if (err) {
      console.error('Error executing query:', err);
      res.status(500).json({ error: 'Error fetching products' });
    } else {
      // Store the products in an array
      const products = results;

      // Send the products as a JSON response
      res.json(products);
    }
  });
});
// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});