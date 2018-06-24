FROM nvidia/cuda:9.2-cudnn7-runtime-ubuntu16.04
LABEL author="Hu Yao <hooyao@gmail.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
#ENV CONDA_BIN=https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh
ENV CONDA_BIN=https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL ${CONDA_BIN} -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes
ENV PATH /opt/conda/bin:$PATH

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/ && \
    conda config --set show_channel_urls yes

RUN conda install -y python=3.6 && \
    conda update conda && \
    # use official channel
    #conda install pytorch torchvision cuda91 -c pytorch &&\
    # use tsinghua channel
    conda install pytorch torchvision cuda91 &&\
    conda install pandas scikit-learn scipy matplotlib sympy jupyter nb_conda -y &&\
    conda clean -a && \
    rm -rf /opt/conda/pkgs/*

RUN mkdir /root/pyprojects
WORKDIR /root/pyprojects
VOLUME /root/pyprojects

# IPython
EXPOSE 8888

