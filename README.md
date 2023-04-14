# Dockerfile for Machine Learning with PyTorch and TensorFlow

This Dockerfile provides a complete environment for machine learning with PyTorch and TensorFlow using CUDA. It uses the `nvidia/cuda:11.6.0-base-ubuntu18.04` base image and installs the following packages:

- Python 3.9
- JupyterLab
- pandas
- numpy
- matplotlib
- seaborn
- scikit-learn
- scipy
- PyTorch 1.13.1 with CUDA 11.6
- TensorFlow (latest version)

## Build or Pull

### Build
To build the Docker image, run the following command:
```bash
docker build -t my-deeplearning-jupyterlab .
```
### Pull
To pull the Docker image from GitHub Packages, run the following command:
```bash
docker pull ghcr.io/williamjeong2/dl-docker/my-deeplearning-jupyterlab:latest
```


## Run

To run the Docker container and start JupyterLab, run the following command:
```bash
docker run --gpus all -p 8888:8888 -v /path/to/your/notebooks:/workspace my-deeplearning-jupyterlab
```

- `--gpus all` option enables GPU acceleration
- `-p 8888:8888` option maps port 8888 in the container to port 8888 on the host machine
- `-v /path/to/your/notebooks:/workspace` option mounts the directory containing your Jupyter notebooks to the `/workspace` directory in the container

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
