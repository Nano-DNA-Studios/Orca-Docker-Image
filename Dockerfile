FROM mrdnalex/openmpi:latest

RUN adduser --gecos "" --disabled-password orca \
    && echo "orca:FormulaNano" | chpasswd

# Add orca to sudoers
RUN adduser orca sudo

# Allow passwordless sudo for orca (optional, but convenient for development)
RUN echo 'orca ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN usermod -aG sudo orca

COPY . .

USER orca

RUN sudo mkdir Orca

RUN sudo chmod +x orca_6_0_0_linux_x86-64_shared_openmpi416.run

RUN sudo ./orca_6_0_0_linux_x86-64_shared_openmpi416.run --target Orca --noexec

RUN rm orca_6_0_0_linux_x86-64_shared_openmpi416.run