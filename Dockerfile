FROM mrdnalex/openmpi:latest

RUN adduser --gecos "" --disabled-password orca \
    && echo "orca:FormulaNano" | chpasswd

# Add orca to sudoers
RUN adduser orca sudo

# Allow passwordless sudo for orca (optional, but convenient for development)
RUN echo 'orca ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN usermod -aG sudo orca

USER orca

COPY . .