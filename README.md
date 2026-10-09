# ASCII Art Web Dockerize

## Description

A web application that converts text into ASCII art using different banner styles. Built with Go and HTML and CSS and Docker, featuring a clean interface for transforming text into stylized ASCII representations.

## Authors

- Elmehdi Rezoug (@erezzoug)
- Aymane Bouzerda (@abouzerd)

## Usage

### Running the Server

Build and run locally:

```bash
git clone https://github.com/zoro-craft/ascii-art-web-dockerize
cd ascii-art-web-dockerize
docker build -t elmehdirezoug/ascii-art:1.0.0 .
docker run -d -p 8080:8080 elmehdirezoug/ascii-art:1.0.0
```

Or pull the published image from Docker Hub:

```bash
docker run -d -p 8080:8080 elmehdirezoug/ascii-art:1.0.0
```

Or use Docker Compose:

```bash
docker compose up -d
```

Then open `http://localhost:8080` in your browser. 

### Using the App

1. Enter your text in the textarea
2. Select a banner style (Standard, Shadow, or Thinkertoy)
3. Click Submit
4. View your generated ASCII art

## Implementation Details

### Algorithm

Each banner file contains 856 lines representing 8 lines of ASCII art per character (ASCII 32-126) plus spacing.

**Processing flow:**
1. Validate input (printable ASCII characters only)
2. Load selected banner file
3. For each character:
   - Calculate line index: `(ASCII_code - 32) × 9 + line_height`
   - Extract 8 lines from banner
   - Concatenate horizontally
4. Build final output

**Routes:**
- `GET /` → Main page with form
- `POST /ascii-art` → Process text and return ASCII art
- `GET /style.css` → CSS stylesheet

**HTTP Status Codes:**
- 200 - Success
- 400 - Invalid input or banner
- 404 - Page not found
- 405 - Invalid HTTP method
- 500 - Internal server error

### Project Structure

```
ascii-art-web-dockerize/
├── asciigenerator/
│   ├── generator.go
│   └── utils.go
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── handlers/
│   ├── homePageHandler.go
│   ├── asciiArtHandler.go
│   ├── cssHandler.go
│   └── errorHandler.go
├── banners/
│   ├── standard.txt
│   ├── shadow.txt
│   └── thinkertoy.txt
├── templates/
│   ├── index.html
│   └── error.html
├── assets/
│   └── style.css
├── main.go
└── go.mod
```

Built using Go standard library and Docker.
