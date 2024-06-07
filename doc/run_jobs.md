# Running Jobs

## Use existing moddules
```
module avail, module list, module load, module purge
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
- Your connections will remain active until you explicitly Terminate the FastX session. 
- Please take care to terminate sessions after your work is complete.
