# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install prerequisites (corrected syntax)
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    ca-certificates

# Install Node.js (and npm) from NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json for dependencies installation
COPY package*.json ./

# Install the app dependencies (npm install)
RUN npm install

# Copy the rest of the application files into the container
COPY . .

# Expose the port the app will run on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]

