# -------------------
# Stage 1 – Scraper
# -------------------
FROM node:18-slim AS scraper

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

RUN apt-get update && apt-get install -y \
    chromium \
    fonts-liberation \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json .
RUN npm install

COPY scrape.js .

ARG SCRAPE_URL=https://github.com/tarunalthi034
ENV SCRAPE_URL=${SCRAPE_URL}

RUN node scrape.js

# -------------------
# Stage 2 – Python Host
# -------------------
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --from=scraper /app/scraped_data.json .

COPY server.py .

EXPOSE 5000

CMD ["python", "server.py"]
