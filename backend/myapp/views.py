from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.



def exemple(request):
    return HttpResponse("Hello world")