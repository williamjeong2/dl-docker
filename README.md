# dl-


## build dockerfile
```bash
docker build -t my-deeplearning-jupyterlab .
```

## run docker image
```bash
docker run --gpus all -p 8888:8888 -v /your/local/path:/workspace my-deeplearning-jupyterlab
```
