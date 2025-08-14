# Use the official Postiz image
FROM ghcr.io/gitroomhq/postiz-app:latest

# Expose port 5000 (default for Postiz)
EXPOSE 5000

# Start the application using default entrypoint from image