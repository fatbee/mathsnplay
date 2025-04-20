# Use Node.js as the base image
FROM node:18-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application for production
RUN npm run build

# Install a simple HTTP server to serve the static content
RUN npm install -g http-server

# Expose the port the app will run on
EXPOSE 8080

# Command to run the application
CMD ["http-server", "dist", "-p", "8080"]
