# Use a base image with SQL Server tools
FROM mcr.microsoft.com/mssql-tools

# Install bash (if not already installed) and necessary tools
RUN apt-get update && \
    apt-get install -y bash && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for backups
RUN mkdir -p /var/opt/mssql/backups

# Copy the run script into the container
COPY run.sh /usr/local/bin/run.sh

# Make the script executable
RUN chmod +x /usr/local/bin/run.sh

# Set the entrypoint to the run script
ENTRYPOINT ["/usr/local/bin/run.sh"]
