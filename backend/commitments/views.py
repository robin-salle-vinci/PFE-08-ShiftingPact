from django.http import JsonResponse
from django.shortcuts import render
from django.views.decorators.http import require_GET

from questions.models import Challenges, SubChallenges, Questions, Choices


# Create your views here.


@require_GET
def get_one(request):
   return JsonResponse({})