#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Colors Variables
red="1"
green="2"
yellow="3"
blue="4"
purple="5"
lightblue="6"
grey="7"

textColor=$(tput setaf $lightblue)
normal=$(tput sgr0)

# While loops for script arguments
while [ $# -gt 0 ]
do
  case "$1" in

    -c|--color)
      GR='\033[00;32m'
      YE='\033[00;33m'
      LR='\033[01;31m'
      RE='\033[00;31m'
      PU='\033[00;35m'
      CY='\033[00;36m'
      BL='\033[00;34m'
          shift
            ;;
  -red)
      textColor=$(tput setaf $red)
      shift
      ;;
  -green)
      textColor=$(tput setaf $green)
      shift
      ;;
  -yellow)
      textColor=$(tput setaf $yellow)
      shift
      ;;
  -blue)
      textColor=$(tput setaf $blue)
      shift
      ;;
  -purple)
      textColor=$(tput setaf $purple)
      shift
      ;;
  -grey)
      textColor=$(tput setaf $grey)
      shift
      ;;
  *)
      break
      ;;
  esac
done

# ==USER==
user=$(whoami)

# ==HOSTNAME==
hostname=$(HOSTNAME | sed 's/.local//g')
# if hostname is >35 characters, truncates to make it fit on std. 80 window
if [ ${#HOSTNAME} -gt 35 ]
then
   hostname=${HOSTNAME:0:35}
fi

# ==MODEL==
# model=$(system_profiler SPHardwareDataType -detailLevel mini | awk '/Model Identifier/ { print $3 }')
# use grep to find the model in the list, then delete from ) to end of line
# modelname=`grep $model $DIR/Models.txt | sed -e 's/).*/)/g'`

# ==GRAPHICS==
graphics=$(system_profiler SPDisplaysDataType |
awk '/Model/{for (i=1; i<=NF-2; i++) $i = $(i+2); NF-=2; print}' | paste -sd "/" -)

graphicsnoBrand=$(system_profiler SPDisplaysDataType |
awk '/Model/{for (i=1; i<=NF-3; i++) $i = $(i+3); NF-=3; print}' | paste -sd "/" -)

resolution=$(system_profiler SPDisplaysDataType | grep Resolution | cut -d':' -f2 | sed -e 's/^[ \t]*//' | awk '$1=$1' ORS=' ')

# Use system_profiler to find graphics cards, then awk to find 'Model'
# Output of this step is lines such as this:
# > Chipset Model: Intel HD Graphics
# > Chipset Model: NVIDIA GeForce GT 330M
# Use awk with a loop to print the arguments after Model: to end of line
# Use paste to join multiple lines together with a slash if necessary.
# Sample output:
# > graphics:        Intel HD Graphics/NVIDIA GeForce GT 330M
# > graphicsnoBrand: HD Graphics/GeForce GT 330M

# ==IP ADDRESS==

## en1 or en0 should contain the ip address
ipAddress=`ipconfig getifaddr en1`
if [ -z "$ipAddress" ]; then
    ipAddress=`ipconfig getifaddr en0`
fi

# ==VERSION==
versionNumber=$(sw_vers -productVersion) # Finds version number

[[ $versionNumber =~ ^[0-9]+\.[0-9]+ ]] && versionShort="${BASH_REMATCH[0]}" # Get first 2 portions of semver

case $versionShort in
  10.10)
    versionString="Yosemite"
    ;;
  10.9)
    versionString="Mavericks"
    ;;
  10.8)
    versionString="Mountian Lion"
    ;;
  10.7)
    versionString="Lion"
    ;;
  10.6)
    versionString="Snow Leopard"
    ;;
  10.5)
    versionString="Leopard"
    ;;
  10.4)
    versionString="Tiger"
    ;;
  10.3)
    versionString="Panther"
    ;;
  10.2)
    versionString="Jaguar"
    ;;
  10.1)
    versionString="Puma"
    ;;
  10.0)
    versionString="Cheetah"
    ;;
esac

version="OS X $versionNumber $versionString"

# ==UPTIME==
if [ "$(uptime | sed -e "s/:/ /2" | sed -e "s/,/ /2" | awk '{print $6}')" = "users" ]
    then 
        # 1 hour < uptime < 1 day
        uptime="$(uptime | sed -e "s/:/ /2" | sed -e "s/,/ /2" | awk '{$4=substr($4,1,length($4)-1); print $3 " hours and " $4 " minutes"}')"
    else
        if [ "$(uptime | sed -e "s/:/ /2" | sed -e "s/,/ /2" | awk '{print $5}')" = "min," ]
            then 
                # uptime < 1 hour
                uptime="$(uptime | sed -e "s/:/ /2" | sed -e "s/:/ /2" | sed -e "s/,/ /2" | awk '{print $4 " minutes"}')"
            else 
            # uptime > 1 day
            uptime="$(uptime | sed -e "s/:/ /2" | sed -e "s/,/ /2" | awk '{print $3 " days, " $5 " hours and " $6 " minutes"}')"
        fi
fi

# ==SHELL==
shell="$SHELL"

# ==TERMINAL==
terminal="$TERM"

# ==PACKAGE MANAGER==

# check if brew or macports is installed, then total there packages and set packagehandler
if [ -e /usr/local/bin/brew ]
then
  brewpackages=$(brew list -l | tail -n +2 | wc -l | tr -d ' ')
  packagehandler=$brewpackages
elif [ -f /opt/local/bin/port ] #don't think this is the right directory, need to check later.
then
  macportpackages="`port installed | wc -l | awk '{print $1 }'`"
  packagehandler=$macportpackages
else
    packagehandler=0
fi

# ==CPU==
cpu=$(sysctl -n machdep.cpu.brand_string)
# removes (R) and (TM) from the CPU name so it fits in a standard 80 window
cpu=$(echo "$cpu" | awk '$1=$1' | sed 's/([A-Z]\{1,2\})//g')

# ==MEMORY==
mem=$(sysctl -n hw.memsize)
mem="$((mem/1073741274)) GB"

# ==DISK==
disk=`df -Hl | head -2 | tail -1`
dpercent=`echo $disk | awk '{print $5}'`
dfree=`echo $disk | awk '{print $4}'`
dused=`echo $disk | awk '{print $3}'`
dcapacity=`echo $disk | awk '{print $2}'`


userText="${textColor}User:${normal}"
hostnameText="${textColor}Hostname:${normal}"
modelText="${textColor}Pokemon:${normal} Steelix"
versionText="${textColor}Version:${normal}"
uptimeText="${textColor}Uptime:${normal}"
shellText="${textColor}Shell:${normal}"
terminalText="${textColor}Terminal:${normal}"
packagehandlerText="${textColor}Packages:${normal}"
cpuText="${BL}${textColor}CPU:${normal}"
memoryText="${textColor}Memory:${normal}"
graphicsText="${textColor}Graphics:${normal}"
resolutionText="${textColor}Resolution:${normal}"
diskText="${textColor}Disk:${normal}"
ipText="${textColor}IP:${normal}"

echo -e "

${GR}                     ,            $userText $user
${GR}                  ,##;            $hostnameText $hostname
${GR}                 ####             $modelText $modelname
${GR}                ;#'               $versionText $version
${GR}       ,#####;,   ,;#####;,       $uptimeText $uptime
${GR}     ######################'      $shellText $shell
${YE}    #####################'        $terminalText $terminal
${YE}    #####################         $packagehandlerText $packagehandler
${LR}    #####################         $cpuText $cpu
${RE}    ######################,       $memoryText $mem
${RE}     #######################      $graphicsText $graphicsnoBrand
${PU}      ####################'       $resolutionText $resolution
${BL}        #################'        $diskText $dused / $dcapacity, $dpercent
${BL}         '####''''####'           $ipText $ipAddress
                                       ${normal}
"


