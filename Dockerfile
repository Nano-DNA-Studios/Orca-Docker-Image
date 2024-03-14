FROM mrdnalex/openmpi:latest

RUN adduser orca

RUN adduser orca sudo

USER orca

COPY . .