FROM node:20-alpine

# Install system dependencies
RUN apk add --no-cache g++ make python3 bash nginx

# Install pnpm globally  
RUN npm install -g pnpm@10.6.1

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-workspace.yaml pnpm-lock.yaml ./
COPY apps/ ./apps/
COPY libraries/ ./libraries/

# Install dependencies
RUN pnpm install --no-frozen-lockfile

# Generate Prisma client
RUN pnpm run prisma-generate

# Build the application
RUN NODE_OPTIONS="--max-old-space-size=4096" pnpm run build

# Copy nginx config if exists
RUN if [ -f var/docker/nginx.conf ]; then cp var/docker/nginx.conf /etc/nginx/nginx.conf; else echo "No nginx config found"; fi

# Expose port
EXPOSE 5000

# Start the application
CMD ["pnpm", "run", "pm2-run"]