#!/bin/sh

openocd -f openocd.cfg -c 'program bin/out.elf verify reset exit'
