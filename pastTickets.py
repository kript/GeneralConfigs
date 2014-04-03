#!/usr/bin/env python
# v2 - 28th october 2013: Ensures RT is not accessed via a proxy. Some exception handling too

import re
import string
import getpass
import argparse
try:
	import requests
except:
	print "The requests module needs to be installed"
	exit()
	
def getFromRT(lURL, lusername, lpassword):
	proxies = { "https": "" }
	data = {'user': lusername, 'pass': lpassword}
	r= requests.get(lURL, params=data, proxies=proxies)
	r.encoding = "utf-8"
	#print "Status Code : {}".format(r.status_code)

	resultDict={}
	for result in r.text.splitlines():
		lineSplit=string.split(result,": ")
		if len(lineSplit) > 1:
			#print "Key = {0} Value = {1}".format(lineSplit[0],lineSplit[1])
			resultDict[lineSplit[0]]=lineSplit[1]
	return resultDict




def main():


	# Get command line arguments
	parser = argparse.ArgumentParser(description='Returns the tickets owned or update over the howevermany days for the specified user',epilog="Note: Ensure that RT is not being accessed via a proxy. Set the no_proxy environment variable if necessary: $ export no_proxy=rt.sanger.ac.uk")
	parser.add_argument("--username", help="Username for the RT account used. Defaults to current user if not specified",default=getpass.getuser())
	parser.add_argument("--days", help="How many days to look back. Defaults to 7",default=7)
	args = parser.parse_args()
	access_user = args.username

	
	# Get the password to connect to RT
	print ("Checking for tickets owned by {0} that have been modified over the last {1} days").format(access_user,args.days)
	access_password = getpass.getpass("Enter RT password for {} : ".format(access_user))

	# Here's the URL we're going to query
	queryURL="https://rt.sanger.ac.uk/REST/1.0/search/ticket?query=Owner = '{0}' AND (  Resolved > '-{1} days' OR Created > '-{1} days' OR LastUpdated > '-{1} days' )".format(access_user,args.days)

	# Run the query and return the results as a dictionary
	try:
		rtQuery=getFromRT(queryURL,access_user,access_password)
	except(requests.exceptions.SSLError):
		print "There was an SSL error.\nThis is probably because RT is being accessed by a proxy"
		print "Set the no_proxy environment variable if necessary: $ export no_proxy=rt.sanger.ac.uk"
		exit()
	except(requests.exceptions.ConnectionError):
		print "Unable to connect to :",queryURL
		exit()
	
	# print the results
	for key, value in rtQuery.iteritems():
		print key,value


if __name__ == "__main__":
    main()
	
