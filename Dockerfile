FROM mrdnalex/openmpi:latest

RUN adduser orca

USER orca

COPY . .