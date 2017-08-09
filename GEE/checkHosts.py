#!/usr/bin/python
import sys
import io
import os
from pprint import pprint


class HostObject(object):
  goodHosts = []
  badHosts = []
  def __init__(self,good,bad):
    self.goodHosts = good
    self.badHosts = bad

def ScanHosts(hostfile):
  goodHosts = []
  badHosts = []

  for line in hostfile:
    host = line.strip('\n')
    resp = os.system("ping -c 1 " + host)
    if resp == 0:
      goodHosts.append(host)
    else:
      badHosts.append(host)
  return HostObject(goodHosts,badHosts)

def main(argv):
  try:
    fd = io.open(argv[1], 'r')
  except OSError, e:
    if e.errno == 2:
      print e
      return None
    else:
      raise
  pprint(vars(ScanHosts(fd)))

if __name__ == "__main__":
  main(sys.argv)
