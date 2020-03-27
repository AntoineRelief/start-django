# Dockerfile

# Pull base image
FROM python:3.7

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Set work directory
RUN mkdir /code
WORKDIR /code

# Install dependencies
RUN pip install pipenv
COPY ./Pipfile* /code/
RUN pipenv install --dev

# Copy project
COPY . /code/