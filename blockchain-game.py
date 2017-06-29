#!/usr/bin/env python2

blockchain = ''
queue = []

class server(threading.thread):

    def init():
        self.s = socket.socket()
        self.s.bind(('0.0.0.0', 31337))
        self.s.listen(5)

    def run():
        while True:
            conn, addr = s.accept()


def handleClient(sock, addr):        

    request = sock.recv(4096)
    command, _, params = request.partition(' ')

    if command == "DELTA":
        offset = int(params)
        sock.send(blockchain[offset:])

    elif command == "BLOCK":
        blockchain += params
        
    elif command == "PLAY":
        try:
            response = "CLIENT {}".format(queue.pop(0))
        except IndexError:
            response = "SERVER"
            queue.append(addr)
        finally:
            sock.send(response)

    else:
        sock.send("UNKNOWN COMMAND")

    sock.close()
