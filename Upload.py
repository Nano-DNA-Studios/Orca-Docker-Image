import subprocess

# Build Image
subprocess.run(['docker', 'build', '-t', 'mrdnalex/orca', '.' ], check=True)

# Upload Image
#subprocess.run(['docker', 'login', '-u', 'mrdnalex', '&&', 'docker', 'push', 'mrdnalex/orca' ], check=True)

# docker login -u mrdnalex && docker push mrdnalex/orca

subprocess.run(['docker', "push",'mrdnalex/orca' ], check=True)