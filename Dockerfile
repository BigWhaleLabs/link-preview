# Puppeteer requires certain dependencies. We're using the chrome image as base image
FROM node:18-buster-slim

# Install puppeteer dependencies
RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr

# Copy the app
COPY . ./

# Install your dependencies
RUN yarn

# Expose the port
EXPOSE 1337
EXPOSE 80

# Run the app
CMD yarn build
CMD yarn start
