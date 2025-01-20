Provisioners enable you to install required package for a virtual machine as part of the resource deployment. 

2 Types

local exec: Runs script on local machine.
remote exec : runs script of remote , newly created machine.
file exec: 

format

Must be defined within each resource block affected. Remote exec requires a connection block definition as well as a provisional{ comand = ....} block