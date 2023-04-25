# Base image
FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/mambaforge/bin:${PATH}"
ARG PATH="/root/mambaforge/bin:${PATH}"

# Install basic packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    build-essential \
    git \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    libfontconfig1 \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Mambaforge and Python latest version
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -O ~/mambaforge.sh \
    && bash ~/mambaforge.sh -b -p /root/mambaforge \
    && rm ~/mambaforge.sh \
    && echo ". /root/mambaforge/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc

# Update mamba
RUN mamba update -n base mamba \
    && mamba update --all

# Install JupyterLab and commonly used libraries
RUN mamba install -y -c conda-forge \
    jupyterlab \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    scikit-learn \
    scipy \
    && mamba clean -afy

# Install deep learning libraries (PyTorch and TensorFlow)
RUN mamba install -y -c pytorch -c conda-forge -c nvidia \
    pytorch \
    torchvision \
    torchaudio \
    pytorch-cuda=11.8

# Set up working directory
WORKDIR /workspace

# Expose JupyterLab port
EXPOSE 8888

# Run JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]