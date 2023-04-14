# Base image
FROM nvidia/cuda:11.6.0-base-ubuntu18.04

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

# Install Mambaforge and Python 3.9
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -O ~/mambaforge.sh \
    && bash ~/mambaforge.sh -b -p /root/mambaforge \
    && rm ~/mambaforge.sh \
    && echo ". /root/mambaforge/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc \
    && mamba install -y python=3.9
    

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
    pytorch==1.13.1 \
    torchvision==0.14.1 \
    torchaudio==0.13.1 \
    pytorch-cuda==11.6

# Set up working directory
WORKDIR /workspace

# Expose JupyterLab port
EXPOSE 8888

# Run JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

