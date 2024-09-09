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
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl xz-utils build-essential nano

# Copy Files to Orca Image
COPY . .

# Switch to Orca User
USER orca

# Orca
# Make Orca Software Folder
RUN sudo mkdir Orca
# Make Orca Installer an Executable
RUN sudo chmod +x orca_6_0_0_linux_x86-64_shared_openmpi416.run
# Run installer and Save files to Orca Folder
RUN sudo ./orca_6_0_0_linux_x86-64_shared_openmpi416.run --target Orca --noexec
# Remove the Installer
RUN sudo rm orca_6_0_0_linux_x86-64_shared_openmpi416.run

# XTB Setup
# Make XTB Folder
RUN sudo mkdir XTB
# Extract from the Tar File
RUN sudo tar -xf xtb-6.7.1-linux-x86_64.tar.xz
# Move Files to XTB Folder
RUN sudo mv xtb-dist/* /XTB
# Remove the Tar File and Extracted Folder
RUN sudo rm xtb-6.7.1-linux-x86_64.tar.xz
RUN sudo rm -r xtb-dist

# Create Symbolic Link for Orca
RUN  sudo ln -s /XTB/bin/xtb /Orca/otool_xtb

# Set Environment Variables
ENV PATH=/XTB/bin:$PATH
ENV XTBPATH=/XTB/bin
ENV OMP_STACKSIZE=4G
ENV OMP_NUM_THREADS=4
ENV MKL_NUM_THREADS=4

# Run the Bash Script to Set Environment Variables
RUN ./XTB/share/xtb/config_env.bash