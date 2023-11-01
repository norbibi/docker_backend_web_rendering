How to use:  

```
git clone https://github.com/norbibi/docker_backend_web_rendering.git
cd docker_backend_web_rendering
git clone --branch webui https://github.com/konradbjk/web-gpu-rendering.git
docker-compose up
```

In another terminal:  
```
docker exec -it ${backendContainerName} /bin/bash
yagna payment fund
cd app
npm install
export HOST_BACKEND=db
npm start
```
