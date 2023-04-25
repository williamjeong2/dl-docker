# Dockerfile for Machine Learning with PyTorch and TensorFlow

This repository contains a Dockerfile that creates a Docker image for deep learning development. The image is based on the `nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04` image and includes the following libraries and tools:

- Python 3.9
- JupyterLab
- pandas
- numpy
- matplotlib
- seaborn
- scikit-learn
- scipy
- PyTorch 2.0.0 with CUDA 11.8
- TensorFlow (latest version)

## Build and Run Docker Image

To build and run the dl-docker image, use the following command:

```bash
docker-compose up
```

If you want to change the external port, you can modify it in the `docker-compose.yml` file.  

Then, access JupyterLab in your web browser at `http://localhost:8888`. You will need to enter the token shown in the container logs to login.

```bash
To access the notebook, open this file in a browser:
    file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
Or copy and paste one of these URLs:
    http://(xxxx or 127.0.0.1):8888/lab?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## Acknowledgements

This Dockerfile is inspired by the following repositories:

- [pytorch/pytorch Dockerfile](https://github.com/pytorch/pytorch/blob/master/docker/pytorch/Dockerfile)
- [tensorflow/tensorflow Dockerfile](https://github.com/tensorflow/tensorflow/blob/master/tensorflow/tools/dockerfiles/dockerfiles/gpu.Dockerfile)
