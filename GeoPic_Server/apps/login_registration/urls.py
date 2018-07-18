from django.conf.urls import url
from . import views

urlpatterns=[
    url(r'^$', views.index),
    url(r'^processLogin/$', views.processLogin),
    url(r'^processRegister/$', views.processRegister),
    url(r'^getRecentPosts/$', views.getRecentPosts),
    url(r'^getPost/$', views.getPost),
    url(r'^uploadFile/$', views.uploadFile),
    url(r'^processUpload/$', views.processUpload),
    url(r'^uploadImage/$', views.uploadImage),
]