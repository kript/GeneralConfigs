#!/usr/bin/python
import re, subprocess
#import pprint
#pp = pprint.PrettyPrinter(indent=4)

def get_keychain_pass(account=None, server=None):
    params = {
	'security': '/usr/bin/security',
	'command': 'find-internet-password',
	'account': account,
	'server': server,
	'keychain': '/Users/jc18/Library/Keychains/login.keychain',
    }
    command = "sudo -u %(account)s %(security)s %(command)s -g -a %(account)s  -s %(server)s %(keychain)s " % params
    #print command
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    #print output
    outtext = [l for l in output.splitlines() if l.startswith('password: ')][0]
    #pp.pprint(output)

    return re.match(r'password: "(.*)"', outtext).group(1)

#if run from command line, run the keychain function
if __name__ == '__main__':
    print get_keychain_pass()
