"""
WSGI config for discovery project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.0/howto/deployment/wsgi/
"""
from django.conf import settings
from django.core.wsgi import get_wsgi_application
from whitenoise import WhiteNoise
# import os
# import time
# import traceback
# import signal
# import sys
# #from django.core.wsgi import get_wsgi_application

# try:
#     application = get_wsgi_application()
#     print ('****************WSGI without exception*****************')
# except Exception:
#     print ('################handling WSGI exception#############')
#     # Error loading applications
#     if 'mod_wsgi' in sys.modules:
#         traceback.print_exc()
#         os.kill(os.getpid(), signal.SIGINT)
#         time.sleep(2.5)

application = WhiteNoise(get_wsgi_application(), root="{}/{}".format(settings.BASE_DIR, 'static'))
# # def application(environ, start_response):
# #     if environ['mod_wsgi.process_group'] != '': 
# #         import signal
# #         os.kill(os.getpid(), signal.SIGINT)
# #     return ["killed"]
