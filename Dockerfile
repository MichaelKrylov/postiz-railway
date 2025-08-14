FROM node:20-alpine3.19

# Install system dependencies
RUN apk add --no-cache g++ make py3-pip bash

# Install pnpm and pm2 globally
RUN npm --no-update-notifier --no-fund --global install pnpm@10.6.1 pm2

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-workspace.yaml pnpm-lock.yaml ./
COPY apps/*/package.json ./apps/*/
COPY libraries/*/package.json ./libraries/*/

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy all source code
COPY . .

# Generate Prisma client
RUN pnpm run prisma-generate

# Build the application
RUN NODE_OPTIONS="--max-old-space-size=4096" pnpm run build

# Expose port
EXPOSE 3000

# Start command
CMD ["pnpm", "start"]