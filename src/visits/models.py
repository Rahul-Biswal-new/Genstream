from django.db import models

# Create your models here.
class PageVisits(models.Model):
    path = models.TextField()
    TimeStamp = models.DateTimeField(auto_now_add=True)
    # pass