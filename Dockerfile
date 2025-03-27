# Use the latest Nginx image
FROM nginx:latest

# Copy all website files to the Nginx web root
COPY . /usr/share/nginx/html

# Expose port 80 for web traffic
EXPOSE 80

# Keep Nginx running in the foreground
CMD ["nginx", "-g", "daemon off;"]

