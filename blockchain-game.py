#!/usr/bin/env python
import threading
import socket
import logging

logging.basicConfig(level=logging.INFO,
                    format='[%(levelname)s] (%(threadName)-10s) %(message)s',
                    )

blockchain = ''
queue = []

class Server(threading.Thread):

    def __init__(self):
        super(Server, self).__init__()
        self.name = "Server"
        self.s = socket.socket()
        self.s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.s.bind(('0.0.0.0', 31337))
        self.s.listen(5)

    def run(self):
        while True:
            conn, addr = self.s.accept()
            t = threading.Thread(target=handleClient, args=(conn, addr))
            t.start()
            logging.debug("new thread created for {}".format(addr))


def handleClient(sock, addr):        
    global blockchain
    global queue
    request = sock.recv(4096).rstrip()
    logging.info("HOST: {}\tREQUEST: {} ".format(addr[0], request))
    command, _, params = request.rstrip().partition(' ')

    if command == "DELTA":
        offset = int(params)
        sock.send(blockchain[offset:]+'\n')
   
    elif command == "BLOCK":
        blockchain += params
        logging.debug("Block added: {}".format(params))
        sock.send("200 OK\n")
        
    elif command == "PLAY":
        try:
            x = queue.pop(0)
            response = "CLIENT {}:{}\n".format(x[0], x[1])
            
        except IndexError:
            response = "SERVER {}\n".format(addr[1])
            queue.append(addr)
            
        except Exception as e:
            response = "501 SERVER ERROR\n"
            logging.error(e)

        finally:
            sock.send(response)
            #logging.debug("CURRENT QUEUE: {}".format(queue))

    else:
        sock.send("UNKNOWN COMMAND\n")
        logging.warning("Unknown Command: {}".format(command))

    sock.close()
    logging.debug("Thread Exiting")

if __name__ == "__main__":
    server = Server()
    server.start()
    logging.info("Server started")