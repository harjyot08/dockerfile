FROM nginx:latest

# Install Git to clone the repository
RUN apt-get update && apt-get install -y git

# Remove the existing files in the Nginx HTML directory
RUN rm -rf /usr/share/nginx/html/*

# Clone the repository into the Nginx HTML directory
RUN git clone https://github.com/harjyot08/my-car.git /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Command to run Nginx (it runs by default in the background)
CMD ["nginx", "-g", "daemon off;"]
