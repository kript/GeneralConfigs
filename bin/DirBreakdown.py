#!/usr/env/python
# script to report on the disk usage of a
#  directory by filetype (extension)


filebreakdown = {}
total = 0

for root, dirs, files in os.walk("Music/"):
    for file in files:
        statfile = os.path.join(root, file)
        print statfile
        fileName, fileExtension = os.path.splitext(statfile)
        if fileExtension:
            fileType = fileExtension.lower().lstrip(".")
            if filebreakdown.has_key(fileType):
                filebreakdown[fileType] += os.path.getsize(statfile)
            else:
                filebreakdown[fileType] = os.path.getsize(statfile)

for key in filebreakdown:
    print key + " occupies : " + str(((filebreakdown[key] /1024)/1024)/1024) + "GB"

