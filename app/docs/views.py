from django.shortcuts import render

def doc_page(request):
    return render(request, 'doc-index.html')