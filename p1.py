#root@host~]# pip3 install prometheus_client

#root@host~]# vi p1.py {enter}

import http.server
from prometheus_client import start_http_server
import time

class MyHandler(http.server.BaseHTTPRequestHandler):
	def do_GET(self):
		self.send_response(200)
		self.end_headers()
		self.wfile.write(b"Hello")
		self.other()
	def other(self):
		while(True):
			time.sleep(2)
			t=t+10


if __name__ == '__main__':
	start_http_server(8000)
	server=http.server.HTTPServer(('localhost',8001),MyHandler)
	server.serve_forever()
