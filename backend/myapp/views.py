from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.template.defaultfilters import date

from myapp.models import Person


# Create your views here.



def exemple(request):
    data = {
        'message': 'Hello world'
    }
    person = Person(
        email="john.doe@example.com",
    )
    person.save()
    return JsonResponse(data)




