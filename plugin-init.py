#!/usr/bin/python

import os, sys

current_name = "php-script-plugin-template"
new_name = sys.argv[1]


def update_folder(path, current_name, new_name):
    os.rename(path + current_name, path + new_name)
    if( os.path.exists(path + new_name)):
        print ("OK: " + path + new_name + " updated")
    else:
        print ("Error: " +  + path + new_name + "failed to update")


print ("updating plugin with new name: " + new_name + "\n")

#update the directory names in the various files subfolders
print ("Updating Folder Paths:")
update_folder("pkg/files/plugins/scripts/", current_name, new_name)
update_folder("pkg/files-posix/plugins/scripts/", current_name, new_name)
update_folder("pkg/files-win/plugins/scripts/", current_name, new_name)


#rename the xml file in pkg & update contents
print "Creating and updating " + new_name + ".xml with new name & paths"
old_xml_path = "pkg/" + current_name + ".xml"
new_xml_path = "pkg/" + new_name + ".xml"
if (os.path.exists(old_xml_path)):
    old_xml = open(old_xml_path, 'r')
    new_xml = open(new_xml_path, 'w')

    for line in old_xml:
        new_xml.write(line.replace(current_name, new_name))

    old_xml.close()
    new_xml.close()

if (os.path.exists(new_xml_path)):
    print (new_xml_path + " exists")
else:
    print (new_xml_path +"does not exist?")





