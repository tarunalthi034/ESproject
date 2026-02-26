# ESproject
Web Scraper & JSON Host
Overview :
This project demonstrates a multi-stage Docker architecture combining:
Node.js + Puppeteer + Chromium → Dynamic web scraping
Python + Flask → Lightweight JSON hosting API
The container scrapes a user-specified URL and serves the extracted data over HTTP.
Architecture:
User → Docker Container
        ├── Stage 1: Node.js Scraper
        │     ├── Chromium
        │     ├── Puppeteer
        │     └── scraped_data.json
        │
        └── Stage 2: Python Host
              ├── Flask API
              └── Serves JSON
    Scraper Stage (Node.js):
    Base Image: node:18-slim
Installs:
Chromium
Puppeteer Core
Responsibilities:
Launch headless browser
Navigate to target URL
Extract data (title, heading, etc.)
Save JSON file
Hosting Stage
Base Image: python:3.10-slim
Installs:
Flask
Responsibilities:
Read scraped JSON
Serve via HTTP endpoint
  Project Structure :
  .
├── Dockerfile
├── scrape.js
├── server.py
├── package.json
├── requirements.txt
└── README.md
Build Instructions
docker build -t web-scraper 
Run Container
.docker run -p 5000:5000 \
  -e SCRAPE_URL=https://github.com/tarunalthi034 \
  web-scraper
  Access Output:
  
  <img width="1910" height="550" alt="Screenshot 2026-02-26 142403" src="https://github.com/user-attachments/assets/3531545b-7dbd-4b6e-aada-c71cfe931b3d" />

