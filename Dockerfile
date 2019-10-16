FROM pytorch/pytorch:1.3-cuda10.1-cudnn7-runtime
LABEL author="Hu Yao <hooyao@gmail.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN conda install pandas scikit-learn matplotlib sympy jupyter nb_conda -y &&\
    conda clean -a && \
    rm -rf /opt/conda/pkgs/*

RUN mkdir /root/pyprojects
WORKDIR /root/pyprojects
VOLUME /root/pyprojects

# IPython
EXPOSE 8888

