from django.http import HttpResponse
from django.shortcuts import render

def home(request):
    # return HttpResponse("Welcome to the home page!")
    return render(request, 'base.html')

def about_view(request):
    return HttpResponse("Welcome to the about page!")