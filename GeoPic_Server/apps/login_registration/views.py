from django.shortcuts import render, HttpResponse, redirect
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from apps.login_registration.models import *
import bcrypt

def index(request):
    return HttpResponse('You are set up correctly')

@csrf_exempt
def processLogin(request):
    if request.method!='POST':
        print('Someone is not posting')
        return HttpResponse('You are not posting!')
    username=request.POST['username']
    if len(User.objects.filter(username=username))==0:
        return JsonResponse('Invalid username')
    user = User.objects.get(username=username)
    if bcrypt.checkpw(user.password.encode(), request.POST['password'].encode()):
        return JsonResponse('Successful Login')
    return JsonResponse('Invalid login')

@csrf_exempt
def processRegister(request):
    if request.method!='POST':
        print('Someone is not posting for register')
        return HttpResponse('You are not posting')
    first_name=request.POST['first_name']
    last_name=request.POST['last_name']
    username=request.POST['username']
    password=request.POST['password']
    if len(User.objects.filter(username=username))>0:
        return JsonResponse('Username already exists')
    hashedPW=bcrypt.hashpw(password.encode(), bcrypt.gensalt())
    User.objects.create(first_name=first_name, last_name=last_name, username=username, password=hashedPW)
    return JsonResponse('User successfully created')
# Create your views here.
