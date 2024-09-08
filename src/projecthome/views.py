from django.http import HttpResponse
from django.shortcuts import render

def demo(request):
    return HttpResponse("Welcome to the home page!")