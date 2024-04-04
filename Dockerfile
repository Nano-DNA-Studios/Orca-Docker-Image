FROM mrdnalex/openmpi:latest

RUN adduser orca

RUN adduser orca sudo

RUN usermod -aG sudo orca

USER orca

COPY . .