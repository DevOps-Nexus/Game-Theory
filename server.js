/**
 * Gamified Learning — self-hosted development server
 *
 * Serves the static site locally so contributors can preview
 * changes without a separate HTTP server.
 *
 * Usage:
 *   node server.js          # default port 3000
 *   PORT=8080 node server.js
 */

'use strict';

const http = require('node:http');
const fs   = require('node:fs');
const path = require('node:path');

const PORT = process.env.PORT || 3000;
const ROOT = __dirname;

const MIME_TYPES = {
  '.html': 'text/html; charset=utf-8',
  '.css':  'text/css; charset=utf-8',
  '.js':   'text/javascript; charset=utf-8',
  '.json': 'application/json',
  '.png':  'image/png',
  '.jpg':  'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif':  'image/gif',
  '.svg':  'image/svg+xml',
  '.pdf':  'application/pdf',
  '.ico':  'image/x-icon',
};

const server = http.createServer((req, res) => {
  const urlPath = req.url.split('?')[0];

  // Reject path-traversal sequences before any filesystem access
  const segments = urlPath.split('/');
  if (segments.some(s => s === '..')) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  // Normalise root request to index.html
  const filePath = path.join(ROOT, urlPath === '/' ? 'index.html' : urlPath);

  // Final boundary check — resolved path must be inside ROOT
  if (!filePath.startsWith(ROOT + path.sep)) {
    res.writeHead(403);
    res.end('Forbidden');
    return;
  }

  fs.readFile(filePath, (err, data) => {
    if (err) {
      if (err.code === 'ENOENT') {
        res.writeHead(404);
        res.end('Not found');
      } else {
        res.writeHead(500);
        res.end('Internal server error');
      }
      return;
    }

    const ext      = path.extname(filePath).toLowerCase();
    const mimeType = MIME_TYPES[ext] || 'application/octet-stream';

    res.writeHead(200, { 'Content-Type': mimeType });
    res.end(data);
  });
});

server.listen(PORT, () => {
  console.log(`Gamified Learning server running at http://localhost:${PORT}/`);
});
