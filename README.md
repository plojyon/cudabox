# CUDA box
Docker container for CUDA development.

Generate keys  
```
ssh-keygen -t rsa -b 4096 -f ./keys/ssh_host_rsa_key -P ""
ssh-keygen -t ecdsa -f ./keys/ssh_host_ecdsa_key -P ""
ssh-keygen -t ed25519 -f ./keys/ssh_host_ed25519_key -P ""
```

(Re)build the image  
`docker build . -t cudabox:v1`

Run the container  
`docker run -h cudabox --name cudabox --gpus all -d -p 8080:22 cudabox:v1`

Connect to container (password is `root`)  
`ssh root@localhost -p 8080`

Backup files from the container and delete the container  
``docker cp cudabox:/root ./files/`date '+%Y-%m-%d'`-$RANDOM``  
`docker kill cudabox`  
`docker rm cudabox`


<!--
docker kill cudabox && docker rm cudabox && docker build . -t cudabox:v1 && docker run -h cudabox --name cudabox --gpus all -d -p 8080:22 cudabox:v1
docker kill cudabox; docker rm cudabox; docker build . -t cudabox:v1; docker run -h cudabox --name cudabox --gpus all -d -p 8080:22 cudabox:v1
-->
