#!/usr/bin/bash
#for example:
# vm.sh /mnt/bigmedia/vms/winnt winnt /mnt/bigmedia/vms/winnt/nt5.iso Windows2000 10006
#DIRECTORY = "$1"
#BOXNAME = "$2"
#ISO = "$3"
#OSTYPE = "$4"
#PORT = "$5"
VBoxManage createvm --name "$2" --ostype "$4" --register --basefolder "$1"
VBoxManage createhd --filename "$1/$2.vdi" --size 5000
VBoxManage storagectl "$2" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage storageattach "$2" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$1/$2.vdi"
VBoxManage storagectl "$2" --name "IDE Controller" --add ide --controller PIIX4       
VBoxManage storageattach "$2" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "$3"      
VBoxManage modifyvm "$2" --boot1 dvd --boot2 disk --boot3 none --boot4 none 
VBoxManage modifyvm "$2" --vrde on                  
VBoxManage modifyvm "$2" --vrdemulticon on --vrdeport "$5"
VBoxHeadless --startvm "$2"
