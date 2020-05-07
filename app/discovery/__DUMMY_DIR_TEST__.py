import os
from django.conf import settings

sep = os.sep


BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DOC_DIR = os.path.join(os.path.dirname(BASE_DIR), 'app','frontend','src')
STATIC_DIR = os.path.join(BASE_DIR, 'static')
STATIC_DOC_DIR = os.path.join(BASE_DIR, 'static', 'docs')
STATIC_ROOT = os.path.join(os.path.dirname(BASE_DIR), 'static')
root="{}/{}".format(BASE_DIR, 'static')

print(os.path.abspath(__file__))
print(os.path.dirname(os.path.abspath(__file__)))
print("base directory",BASE_DIR)
print("frontend doc directory",DOC_DIR)
print("static directory", STATIC_DIR)
print("static doc directory", STATIC_DOC_DIR)
print("static root", STATIC_ROOT)
print(root)
