# Set the python version as a build-time argument with Python 3.12 as the default
ARG PYTHON_VERSION=3.12-slim-bullseye
FROM python:${PYTHON_VERSION}

# Create a virtual environment
RUN python -m venv /opt/venv

# Set the virtual environment as the current location
ENV PATH=/opt/venv/bin:$PATH

# Upgrade pip
RUN pip install --upgrade pip

# Set Python-related environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install OS dependencies for required libraries
RUN apt-get update && apt-get install -y \
    libpq-dev \
    # for PostgreSQL
    libjpeg-dev \
    # for Pillow
    libcairo2 \
    # for CairoSVG
    gcc \
    # for compiling some Python dependencies
    && rm -rf /var/lib/apt/lists/*

# Create the code directory in the container
RUN mkdir -p /code

# Set the working directory
WORKDIR /code

# Copy the requirements file into the container
COPY requirements.txt /tmp/requirements.txt

# Install the Python project dependencies
RUN pip install -r /tmp/requirements.txt

# Copy the project code into the container's working directory
COPY ./src /code

# Set the Django default project name as a build argument
ARG PROJ_NAME="genstreamhome"

# Create a bash script to run the Django project
RUN printf "#!/bin/bash\n" > ./paracord_runner.sh && \
    printf "RUN_PORT=\"\${PORT:-8000}\"\n\n" >> ./paracord_runner.sh && \
    printf "python manage.py migrate --no-input\n" >> ./paracord_runner.sh && \
    printf "gunicorn ${PROJ_NAME}.wsgi:application --bind \"0.0.0.0:\$RUN_PORT\"\n" >> ./paracord_runner.sh

# Make the bash script executable
RUN chmod +x paracord_runner.sh

# Clean up apt cache to reduce image size
RUN apt-get remove --purge -y \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Run the Django project via the runtime script when the container starts
CMD ./paracord_runner.sh
