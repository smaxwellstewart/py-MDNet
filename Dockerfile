FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04


RUN apt update -y
RUN apt install -y \
        build-essential \
        build-essential \
        cmake \
        git \
        unzip \
        pkg-config \
        python-pip \
        libopenblas-dev \
        liblapack-dev \
        cython \
        python-dev \
        python-opencv \
        python-tk \
        tk-dev

RUN rm -rf /var/lib/apt/lists/*


RUN pip install --upgrade pip
RUN pip install http://download.pytorch.org/whl/cu80/torch-0.3.0.post4-cp27-cp27mu-linux_x86_64.whl

RUN pip install \
        numpy \
        scipy \
        mkl \
        nose \
        sphinx \
        pydot-ng \
        keras \
        matplotlib \
        tensorflow \
        image \
        scikit-image \
        scikit-learn \
        torchvision \
        'django<2.0'


WORKDIR /mdnet

COPY . .
RUN chmod -R a+rx ./

ENV dataset=face

WORKDIR /mdnet/tracking/
RUN export DISPLAY=:0.0
CMD python run_tracker.py -s $dataset -f
