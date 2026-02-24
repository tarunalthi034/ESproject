const fs = require("fs");
const puppeteer = require("puppeteer");

(async () => {
  const url = process.env.SCRAPE_URL;

  if (!url) {
    console.error("SCRAPE_URL not set");
    process.exit(1);
  }

  const browser = await puppeteer.launch({
    headless: "new",
    executablePath: "/usr/bin/chromium",
    args: ["--no-sandbox", "--disable-setuid-sandbox"]
  });

  const page = await browser.newPage();
  await page.goto(url, { waitUntil: "domcontentloaded" });

  const data = await page.evaluate(() => ({
    title: document.title,
    firstHeading: document.querySelector("h1")?.innerText || "No H1"
  }));

  await browser.close();

  fs.writeFileSync("scraped_data.json", JSON.stringify(data, null, 2));
})();
