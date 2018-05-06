FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
MAINTAINER Hu Yao <hooyao@gmail.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV CONDA_ENV_NAME=pytorch-04-gpu-36
ENV TORCH_URL_PREFIX=http://download.pytorch.org/whl/cu90/
ENV TORCH_WHEEL_NAME=torch-0.4.0-cp36-cp36m-linux_x86_64.whl

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update --fix-missing && apt-get install -y bzip2 curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl  https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh --output miniconda.sh \
    && chmod +wrx miniconda.sh \
    && sh miniconda.sh -b \
    && rm miniconda.sh
ENV OLD_PATH=$PATH
ENV PATH=/root/miniconda2/bin:$PATH
RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
RUN conda config --set show_channel_urls yes

RUN conda create -n ${CONDA_ENV_NAME} python=3.6 -y
RUN curl ${TORCH_URL_PREFIX}${TORCH_WHEEL_NAME} --output ${TORCH_WHEEL_NAME} \
    && chmod +wrx ${TORCH_WHEEL_NAME} \
    && source activate ${CONDA_ENV_NAME} \
    && pip install --ignore-installed --upgrade ${TORCH_WHEEL_NAME} \
    && pip install torchvision \
    && conda install pandas scikit-learn scipy matplotlib sympy -y \
    && conda install jupyter nb_conda -y \
    && conda clean -a \
    && rm ${TORCH_WHEEL_NAME}
ENV PATH=/root/miniconda2/envs/${CONDA_ENV_NAME}/bin/:$OLD_PATH

RUN mkdir /root/pyprojects
WORKDIR /root/pyprojects
VOLUME /root/pyprojects

# IPython
EXPOSE 8888

