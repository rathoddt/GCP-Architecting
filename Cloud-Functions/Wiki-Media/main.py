import functions_framework
import urllib

@functions_framework.http
def get_wikimedia(request):
  try:
      url = "http://10.142.0.2/wiki/Main_Page"
      req = urllib.request.Request(url)
      response = urllib.request.urlopen(req)
      return response.read()
  except Exception as e:
      print(e)
      return str(e)