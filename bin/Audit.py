#/usr/bin/env python
'''
Takes a Maildir directory and produces a report and png file with horizontal
bar chart (can be vertical, see commented out bits) of the count of each
email sender's address
'''

import mailbox

mbox = mailbox.Maildir('/Users/jc18/.mail/sanger.ac.uk/INBOX.HPC.AlertSurvey2014/')
dict = {}
for message in mbox:
    #some of the message appear corrupt, so skip where we can't get the date
    try:
        date = str(message.getdate('Date')[0]) \
            + str(message.getdate('Date')[1]) \
            + str(message.getdate('Date')[2])

    except Exception, e:
        next
    
    subj = message['subject']
    frm = message['from']
    #print date + " " + frm + " " + subj
    if message['from'] in dict:
        dict[message['from']] += 1
        #print "adding"  + message['from'] 
    else:
        dict[message['from']] = 1
        #print "SKIPPING" + message['from']

emailaddr = []
count = []

#now the number breakdown
for key in sorted(dict):
    print str(dict[key]) + ": " + key
    emailaddr.append(key)
    count.append(dict[key])


import numpy as np
import matplotlib.pyplot as plt

x_pos = len(count)

fig = plt.figure()
#fig.subplots_adjust(bottom=0.4) #make the space at bottom larger to fit emails
fig.subplots_adjust(left=0.4) #make the space at side larger to fit emails
ax = fig.add_subplot(111)

#ax.bar(np.arange(x_pos), count)
ax.barh(np.arange(x_pos), count)
#plt.xticks(np.arange(x_pos), emailaddr, rotation=90, fontsize=6)
plt.yticks(np.arange(x_pos), emailaddr, fontsize=6)
#plt.xlabel('Email counts by address')
plt.ylabel('Email counts by address')
plt.title('Spam Count!')
plt.savefig('email.png')


