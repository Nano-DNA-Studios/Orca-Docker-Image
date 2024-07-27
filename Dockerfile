FROM mrdnalex/openmpi:latest

RUN adduser --gecos "" --disabled-password orca \
    && echo "orca:FormulaNano" | chpasswd

# Add orca to sudoers
RUN adduser orca sudo

# Allow passwordless sudo for orca (optional, but convenient for development)
RUN echo 'orca ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add Orca User to Sudo Group
RUN usermod -aG sudo orca

# Update and install necessary packages
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl xz-utils build-essential

# Copy Files to Orca Image
COPY . .

# Switch to Orca User
USER orca

# Make Orca Software Folder
RUN sudo mkdir Orca

# Make Orca Installer an Executable
RUN sudo chmod +x orca_6_0_0_linux_x86-64_shared_openmpi416.run

# Run installer and Save files to Orca Folder
RUN sudo ./orca_6_0_0_linux_x86-64_shared_openmpi416.run --target Orca --noexec

# Remove the Installer
RUN sudo rm orca_6_0_0_linux_x86-64_shared_openmpi416.run