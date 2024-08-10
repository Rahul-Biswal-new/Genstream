import pathlib
from django.http import HttpResponse
from django.shortcuts import render
from visits.models import PageVisits

this_dir = pathlib.Path(__file__).resolve().parent

def home_page_view(request, *args, **kwargs):
    # print(this_dir)
    queryset = PageVisits.objects.all()
    print(queryset)

    my_context = {
        "page_title": "my_page",
        "queryset" : queryset,
        "page_visits_count": queryset.count()
    }
    html_temp = "base.html"

    PageVisits.objects.create(path = request.path)
    return render(request, html_temp, my_context)

def home(request):
    return render(request, "home.html")