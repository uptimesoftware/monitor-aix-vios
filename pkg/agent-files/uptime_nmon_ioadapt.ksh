#!/usr/bin/ksh

mkfifo /tmp/nmon_fiber.pipe
nmon -^ -s 60 -c 1 -F /tmp/nmon_fiber.pipe -yoverwrite=1 &
grep -ie ioadapt -e zzzz /tmp/nmon_fiber.pipe | nmon_ioadapt.pl
unlink /tmp/nmon_fiber.pipe
