# Running Jobs

## Use existing moddules
```
# list available modules
module avail [optional_program_name]
# list loaded module
module list
# unload a module
module rm [module]
# unload all loaded modules
module purge

# load specific modules
module load R; R
module load stata; stata-mp
module load sas; sas -memsize 0 -sortsize 0 -maxmemquery 0 -work /kellogg/tmp [program.sas]
module load matlab/r2016a; matlab
```

## Monitor your processes
```
free -h
top -u your-netid
ps -u your-netid
kill -9 pid_number
killall [process] - kill all processes by name
```
## Long runtime jobs
### ssh
```
nohup stata -b do my_program.do &
nohup Rscript my_program.R &
nohup python my_program.py &
```
### FastX
- FastX will continue to run your jobs even after your close your browser window and reboot your computer. 
- Your connections will remain active until you **explicitly terminate** the FastX session. 
- Please take care to terminate sessions after your work is complete.
