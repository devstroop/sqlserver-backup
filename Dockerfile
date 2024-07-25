# Use the official Microsoft SQL Server image as the base
FROM mcr.microsoft.com/mssql/server:2019-latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    curl \
    nano \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Copy the script into the container
COPY run.sh /usr/local/bin/run.sh

# Make the script executable
RUN chmod +x /usr/local/bin/run.sh

# Set the default command to run the script
ENTRYPOINT ["/usr/local/bin/run.sh"]

# Set the default working directory
WORKDIR /var/opt/mssql/backups
