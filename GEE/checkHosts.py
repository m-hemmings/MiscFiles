#!/usr/bin/python
import sys
import io
import os
import subprocess
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
    with open(os.devnull, 'w') as DEVNULL:
      try:
        subprocess.check_call(
          ['ping','-c','1',host],
          stdout=DEVNULL,stderr=DEVNULL #to suppress output
        )
        goodHosts.append(host)
      except subprocess.CalledProcessError:
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
  result = ScanHosts(fd)
  #DEBUG PRINT
  pprint(vars(result))
  return result

if __name__ == "__main__":
  main(sys.argv)
