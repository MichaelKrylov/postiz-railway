# Use the official Postiz image
FROM ghcr.io/gitroomhq/postiz-app:latest

# Expose port 5000 (default for Postiz)
EXPOSE 5000

# Environment variables will be set by Railway
ENV PORT=5000

# Start the application using the correct command
CMD ["node", "dist/apps/backend/main.js"]