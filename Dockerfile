# Version: 1.2
# Name: odc-dev
# for Python 3.6

FROM yan047/python3.6:1.0

MAINTAINER "boyan.au@gmail.com"

# In case someone loses the Dockerfile
RUN rm -rf /etc/Dockerfile
COPY Dockerfile /etc/Dockerfile

# install gcc for compiling SharedArray
RUN apt-get update && apt-get install -y gcc

# set environment variables
ENV WORK_BASE /var/agdc
ENV PYTHON_VERSION 3.6

# must run with user root
USER root

# create directories
RUN mkdir -p "$WORK_BASE"

# copy environment.yaml to image
COPY environment.yaml "$WORK_BASE"

# change to work directory
WORKDIR "$WORK_BASE"

# install dependencies
RUN conda env update -n root --file "$WORK_BASE"/environment.yaml python="$PYTHON_VERSION" && \
	conda install -y --quiet jupyter sphinx

# the following language settings are required by datacube commands, to be compatible with OS settings.
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
