FROM nvidia/cuda:12.2.0-devel-ubuntu22.04

EXPOSE 22

RUN apt-get update && apt-get install -y \
    git \
    wget \
    vim \
    neofetch \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN echo 'root:root' | chpasswd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    echo 'export CUDA_HOME=/usr/local/cuda' >> /root/.bashrc && \
    echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64' >> /root/.bashrc && \
    echo 'export PATH=$PATH:$CUDA_HOME/bin' >> /root/.bashrc && \
    rm -rf /etc/update-motd.d/* && \
    touch /root/.hushlogin

# SSH key freeze. Otherwise key is invalid on each container rebuild.
COPY keys/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
COPY keys/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
COPY keys/ssh_host_ecdsa_key /etc/ssh/ssh_host_ecdsa_key
COPY keys/ssh_host_ecdsa_key.pub /etc/ssh/ssh_host_ecdsa_key.pub
COPY keys/ssh_host_ed25519_key /etc/ssh/ssh_host_ed25519_key
COPY keys/ssh_host_ed25519_key.pub /etc/ssh/ssh_host_ed25519_key.pub
COPY keys/authorized_keys /root/.ssh/authorized_keys

# Provide a Hello world
COPY hello.cu /root/hello.cu

CMD service ssh start && tail -f /dev/null
