# Use the official Nginx base image
FROM nginx:latest

# Install necessary dependencies (git, etc.)
RUN apt-get update && apt-get install -y \
    git \
    openssh-client \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Add the SSH private key to the container (for GitHub authentication)
# COPY your SSH private key (id_rsa) into the container (ensure it's available)
# You will need to copy your SSH private key here for GitHub authentication
COPY ./id_rsa /root/.ssh/id_rsa

# Set correct permissions for the SSH key
RUN chmod 600 /root/.ssh/id_rsa

# Disable strict host checking (optional, for the sake of automation)
RUN echo -e "Host github.com\n\tStrictHostKeyChecking no\n\n" > /root/.ssh/config

# Clone the Git repository from GitHub
RUN git clone git@github.com:harjyot08/my-car.git

# Copy the cloned repository contents into Nginx's default directory
RUN cp -r /app/my-car/* /usr/share/nginx/html/

# Expose port 80 (default Nginx port)
EXPOSE 80

# Set the default command to start Nginx
CMD ["nginx", "-g", "daemon off;"]
