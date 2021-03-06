# coding: utf-8
import os.path
SITE_ROOT = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))

DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    ('Binet Réseau', 'root@eleves.polytechnique.fr'),
)

MANAGERS = ADMINS

TIME_ZONE = 'Europe/Paris'
LANGUAGE_CODE = 'fr'

SITE_ID = 1
USE_I18N = False
USE_L10N = True

MEDIA_ROOT = os.path.join(SITE_ROOT, 'media')
MEDIA_URL = '/media/'

STATIC_ROOT = os.path.join(SITE_ROOT, 'static')
STATIC_URL = '/static/'
STATICFILES_DIRS = (
    os.path.join(SITE_ROOT, 'dnsapp', 'static'),
)

SECRET_KEY = 'veu&amp;t&amp;z1qmwg_^v@!5k^+jk!&amp;g&amp;+=vqdw-w+rj^hqimzi6k-%8'

TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.Loader',
    'django.template.loaders.app_directories.Loader',
)

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.contrib.auth.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.i18n',
    'django.core.context_processors.tz',
    'django.core.context_processors.static',
    'django.core.context_processors.media',
    'django.contrib.messages.context_processors.messages',
    'django.core.context_processors.request',

    'dnsapp.context_processors.remote_ip',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)

ROOT_URLCONF = 'dnsapp.urls'
WSGI_APPLICATION = 'dnsapp.wsgi.application'

TEMPLATE_DIRS = (os.path.join(SITE_ROOT, 'templates'),)
FIXTURE_DIRS = (os.path.join(SITE_ROOT, 'fixtures'),)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.staticfiles',
    'django.contrib.messages',
    'django.contrib.admin',

    'django_tables2',
    'dnsapp',
)

LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse'
        }
    },
    'handlers': {
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django.request': {
            'handlers': ['mail_admins'],
            'level': 'ERROR',
            'propagate': True,
        },
    }
}

DATABASE_ROUTERS = ['dnsapp.db_router.DbRouter']
DATABASES = {
    'dns': {},
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': 'django.db',
    }
}
