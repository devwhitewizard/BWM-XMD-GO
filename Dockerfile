# Use Node.js 20 as base image
FROM node:20

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    imagemagick \
    webp \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
# Using 'npm install' instead of 'npm ci' because package-lock.json might be missing
RUN npm install

# Copy the rest of the application
COPY . .

# Expose the port (Render uses PORT env var, but 8080 is a common default)
EXPOSE 8080

# Command to start the application
CMD ["node", "index.js"]
