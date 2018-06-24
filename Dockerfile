FROM pytorch/pytorch:0.4_cuda9_cudnn7
LABEL author="Hu Yao <hooyao@gmail.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/ && \
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/ && \
    conda config --set show_channel_urls yes

RUN conda install pandas scikit-learn matplotlib sympy jupyter nb_conda -y &&\
    conda clean -a && \
    rm -rf /opt/conda/pkgs/*

RUN mkdir /root/pyprojects
WORKDIR /root/pyprojects
VOLUME /root/pyprojects

# IPython
EXPOSE 8888

