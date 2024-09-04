from django.shortcuts import render
from .models import Visits
# Create your views here.
def visit_home(request):
    vst = Visits(path = request.path)
    vst.save()

    response = Visits.objects.all()
    return render(request, 'visit_home.html', {'visits': response})