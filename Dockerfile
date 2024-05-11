FROM mrdnalex/openmpi:latest


RUN mkdir /OrcaTemp
RUN mkdir /Orca
COPY . /OrcaTemp


RUN tar -xf /OrcaTemp/orca_5_0_4_linux_x86-64_openmpi411_part1.tar.xz -C /Orca
RUN mv /Orca/orca_5_0_4_linux_x86-64_openmpi411_part1/* /Orca
RUN rm -r /Orca/orca_5_0_4_linux_x86-64_openmpi411_part1

RUN tar -xf /OrcaTemp/orca_5_0_4_linux_x86-64_openmpi411_part2.tar.xz -C /Orca
RUN mv /Orca/orca_5_0_4_linux_x86-64_openmpi411_part2/* /Orca
RUN rm -r /Orca/orca_5_0_4_linux_x86-64_openmpi411_part2

RUN tar -xf /OrcaTemp/orca_5_0_4_linux_x86-64_openmpi411_part3.tar.xz -C /Orca
RUN mv /Orca/orca_5_0_4_linux_x86-64_openmpi411_part3/* /Orca
RUN rm -r /Orca/orca_5_0_4_linux_x86-64_openmpi411_part3
RUN rm -r /OrcaTemp 

RUN adduser orca

RUN adduser orca sudo

RUN usermod -aG sudo orca

USER orca

COPY . .