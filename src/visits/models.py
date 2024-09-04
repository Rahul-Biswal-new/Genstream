from django.db import models

# Create your models here.
class Visits(models.Model):
    path = models.TextField()
    timestamp = models.DateTimeField(auto_now_add = True)
    # pass

    def __str__(self):
        return f"Visit at {self.timestamp}"