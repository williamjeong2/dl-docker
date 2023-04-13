# Base image
FROM nvidia/cuda:11.6.0-base-ubuntu18.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

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

# Install Miniconda and Python 3.9
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.9.2-Linux-x86_64.sh -O ~/miniconda.sh \
    && bash ~/miniconda.sh -b -p /root/miniconda3 \
    && rm ~/miniconda.sh \
    && conda clean -tipsy \
    && ln -s /root/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /root/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc \
    && echo "conda activate base" >> ~/.bashrc

# Install JupyterLab and commonly used libraries
RUN conda install -y -c conda-forge \
    jupyterlab \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    scikit-learn \
    scipy \
    && conda clean -afy

# Install deep learning libraries (PyTorch and TensorFlow)
RUN conda install -y -c pytorch -c conda-forge -c nvidia \
    pytorch \
    torchvision \
    torchaudio \
    pytorch-cuda=11.6 \
    && conda install -y -c anaconda -c conda-forge \
    tensorflow-gpu

# Set up working directory
WORKDIR /workspace

# Expose JupyterLab port
EXPOSE 8888

# Run JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
