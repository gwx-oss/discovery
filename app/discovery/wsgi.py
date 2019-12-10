"""
WSGI config for discovery project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.0/howto/deployment/wsgi/
"""
from django.conf import settings
from django.core.wsgi import get_wsgi_application
from whitenoise import WhiteNoise

#application = WhiteNoise(get_wsgi_application(), root="{}/{}".format(settings.BASE_DIR, 'static'))
def application(environ, start_response):
    if environ['mod_wsgi.process_group'] != '': 
        import signal
        os.kill(os.getpid(), signal.SIGINT)
    return ["killed"]
