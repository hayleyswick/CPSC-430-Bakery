from abc import ABC, abstractmethod

class User(ABC):
	def __init__(self, uname, pword, first, last):
		# add ID assignment
		self.uname = uname
		self.pword = pword
		self.first = first
		self.last = last
	def getUname(self):
		return self.uname
	def setUname(self, newU):
		self.uname = newU

class Baker(User):


class Admin(User):





