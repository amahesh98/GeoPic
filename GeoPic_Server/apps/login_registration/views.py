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
    if 'username' not in request.POST:
        return JsonResponse({'response':'Username not in post'})
    if 'password' not in request.POST:
        return JsonResponse({'response':'Password not in post'})
    print(request.POST)
    username=request.POST['username']
    if len(User.objects.filter(username=username))==0:
        # return JsonResponse('Invalid username')
        return JsonResponse({'response':'Username does not exist in database'})
    
    user = User.objects.get(username=username)
    # if bcrypt.checkpw(user.password.encode(), str(request.POST['password']).encode()):
    if request.POST['password']==user.password:
        response = {'response':'Successful Login', 'first_name':user.first_name, 'last_name':user.last_name, 'username':user.username}
        return JsonResponse(response)
    response = {'response':'Invalid Login'}
    return JsonResponse(response)

@csrf_exempt
def processRegister(request):
    if request.method!='POST':
        print('Someone is not posting for register')
        return HttpResponse('You are not posting')
    print(request.POST)
    first_name=request.POST['first_name']
    last_name=request.POST['last_name']
    username=request.POST['username']
    password=request.POST['password']
    if len(User.objects.filter(username=username))>0:
        return JsonResponse({'response':'Username already exists'})
    # hashedPW=bcrypt.hashpw(password.encode(), bcrypt.gensalt())
    print(first_name, last_name, username, password)
    User.objects.create(first_name=first_name, last_name=last_name, username=username, password=password)
    return JsonResponse({'response':'User successfully created'})
# Create your views here.

@csrf_exempt
def getRecentPosts(request):
    posts = Post.objects.all().order_by('-created_at')[0:20].values()
    data={
        'posts':list(posts)
    }
    return JsonResponse(data)

