FROM mrdnalex/openmpi:latest

COPY . .

RUN adduser orca

RUN adduser orca sudo

RUN usermod -aG sudo orca

USER orca