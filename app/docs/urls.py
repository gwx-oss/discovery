from django.urls import path

from . import views

# test
urlpatterns = [
    path('', views.doc_page, name="docs")
]