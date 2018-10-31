FROM ubuntu:16.04

MAINTAINER Radiant Earth Foundation<code@radiant.earth>

# version settings
# ARG PYTHON_VERSION=3.5


# install dependencies
RUN apt-get update --fix-missing && apt-get install -y --no-install-recommends\ 
        build-essential \
        software-properties-common \
        curl \
        cmake \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        rsync \
        zip \
        unzip \
        git \
        wget \
        vim \
        ca-certificates \
        python3 \
        python3-dev \
        python3-pip \
        ipython3 \
        graphviz \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



# install mapnik ，note: mapnik must install before gdal
RUN apt-get update && apt-get --fix-missing install -y python3-mapnik && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



# install gdal  
RUN add-apt-repository -y ppa:ubuntugis/ppa && \ 
    apt update && \ 
    apt-get install -y --no-install-recommends gdal-bin libgdal-dev python3-gdal && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# install python package
RUN pip3 --no-cache-dir install \
        setuptools

# note: due to pytorch 0.2 rely on numpy 1.13, it's have to upgrade numpy from 1.11.0 to 1.13.1
RUN pip3 --no-cache-dir install --upgrade \
        numpy
RUN pip3 --no-cache-dir install \
        Pillow \
        ipykernel \
        jupyter \
        scipy \
        h5py \
        scikit-image \
        matplotlib \
        pandas \
        scikit-learn \
        sympy \
        shapely \
        bokeh \
        geopandas \
        hyperopt \
        folium \
        ipyleaflet \
        xgboost \
        rasterio \
        progressbar33 \
        opencv-contrib-python \
        tifffile \
        tqdm \
        boto3 \
        bravado \
        && \
    python3 -m ipykernel.kernelspec

RUN pip3 install cython
RUN pip3 install cartopy

RUN git clone --recursive https://github.com/dmlc/xgboost && \
    cd xgboost && \
    make -j4 && \
    cd python-package && \
    python3 setup.py install

RUN mkdir ~/.aws

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# jupyter noteboook
EXPOSE 8888

RUN mkdir /workdir
RUN mkdir /workdir/geojsons

WORKDIR "/workdir"   
 

COPY webinar-v1.0.ipynb /workdir

COPY ATG.geojson /workdir/geojsons

CMD ["/run_jupyter.sh", "--allow-root"]