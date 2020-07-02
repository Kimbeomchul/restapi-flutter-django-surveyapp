from django.urls import path, include
from .views import *

urlpatterns = [
    path("Hello/" , helloAPI),
    path("<int:id>/", randomQuiz),
]