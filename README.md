## How to start

This project only contains four files (including the README), the strict minimum to start a django project. REST and GraphQL API are both compatible with the docker, you will need to install the packages of the chosen API after the installation.

### Docker-compose ( you can jump this one )

Without speaking about the initialisation of the project, and the commands to do so, a quick brief about the docker-compose file.

Django by default creates a default sqlite database, but a lot of problems can occur with this one, so I won't encourage to work with this one. I prefered to add postgres to the project to have a more secure and stable database.

A volume is put in place for the data.

Regarding the python container, the command is a simple runserver. It can be enhanced later, using more complex command, like gunicorn.

I replaced pip and virtualenv by pipenv, a more modern package manager.

### Docker

To start the docker-compose, you will need to set these three constants :

*  POSTGRES_DB
*  POSTGRES_USER
*  POSTGRES_PASSWORD

Put the values inside the docker-compose.yml file, after the name of the constants.

At this point, you can build the containers:

    docker-compose build

Be aware that at this point, nothing will change regarding the structure of the project, you just built the containers.

### Start the project

Run the following command, replacing "<project-name>" by the name of your project :

    docker-compose run --rm web pipenv run django-admin startproject <project-name> .

Be aware that this will create a new folder, but that folder should only contain global functions. You will then create applications inside your projects, to divide the code.

At this point, a manage.py file and a new folder should be added to the project.

### Setup the database

Go to the settings.py file of the new folder. Replace the DATABASE property by this one:

    DATABASES = {
        'default': {
            'ENGINE': 'django.db.backends.postgresql_psycopg2',
            'NAME': '',
            'USER': '',
            'PASSWORD': '',
            'HOST': 'db',
            'PORT': 5432,
        }
    }

For the NAME, USER, and PASSWORD fields, replace by the inputs you used for the docker-compose file.

POSTGRES_DB as NAME
POSTGRES_USER as USER
POSTGRES_PASSWORD as PASSWORD

Save the modifications, and execut default migrations:

    docker-compose run --rm web pipenv run python manage.py migrate

Django includes default migrations, in order to start with a good structure for users and permissions. This structure can be modified later.

### Run the project

You can then start the project:

    docker-compose up

The project will run on localhost 8000. For the moment, nothing is set, but you will be able to access the database administration panel. Go to [localhost](http://localhost:8000/admin)

The form will ask you for an username and a password, for the moment you didn't create them. Run that command:

    docker-compose run --rm web pipenv run python manage.py createsuperuser

This command will create a super user account, which will have access to the database administration panel. Answers the questions prompt, and verify that you can have access to the panel after that.

If everything went good, your project is set up !

### Start to code

The purpose of the document is not to explain you Django, but here is some good links:

[Django documentation](https://docs.djangoproject.com/en/3.0/)

Choose your fighter:

[REST API with Django](https://www.django-rest-framework.org/)

[GraphQL with Django](https://docs.graphene-python.org/projects/django/en/latest/)

In order to install the packages, see following commands.

Once installed, you can start your first application inside your project:

    docker-compose run --rm web pipenv run python manage.py startapp <app-name>

You should keep in mind that the code should be divided into multiples applications, to keep a better structure.

Good luck !

## Usefull commands

### Install new packages :

    docker-compose run --rm web pipenv install <package-name>

### Create django project :

    docker-compose run --rm web pipenv run django-admin startproject <project-name> .

### Add a new app

    docker-compose run --rm web pipenv run python manage.py startapp <app-name>

### Make migrations

    docker-compose run --rm web pipenv run python manage.py makemigrations

### To start the project, run the following :

    docker-compose run --rm web pipenv run python manage.py migrate
    
    docker-compose run --rm web pipenv run python manage.py createsuperuser

### Run tests

    docker-compose run --rm web pipenv run python manage.py test

### Gather static files on production server

    docker-compose run --rm web pipenv run python manage.py collectstatic