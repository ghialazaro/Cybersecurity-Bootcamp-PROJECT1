#!/bin/bash
#runs command to check available memory and saves it to the free_mem.txt file
free > ~/backups/freemem/free_mem.txt

#runs command to check disk usage and saves it to the disk_usage.txt file
du  > ~/backups/diskuse/disk_usage.txt

#runs command to check for open files and saves them to the open_list.txt file
lsof > ~/backups/openlist/open_list.txt

#runs command to check the free disk space and saves it to free_disk.txt
df -h > ~/backups/freedisk/free_disk.txt 