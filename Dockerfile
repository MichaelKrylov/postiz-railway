FROM node:20-alpine

# Install system dependencies
RUN apk add --no-cache g++ make python3 bash

# Install pnpm globally
RUN npm install -g pnpm@10.6.1

# Set working directory
WORKDIR /app

# Copy all files
COPY . .

# Install dependencies
RUN pnpm install

# Generate Prisma client
RUN pnpm run prisma-generate

# Build the application
RUN pnpm run build

# Expose port
EXPOSE 3000

# Start in development mode
CMD ["pnpm", "dev"]