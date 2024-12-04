from django.shortcuts import render
from django.http import HttpResponse, JsonResponse


# Create your views here.



def exemple(request):
    data = {
        'message': 'Hello world'
    }
    return JsonResponse(data)