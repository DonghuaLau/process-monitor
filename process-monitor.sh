# !/bin/sh

CONFIG_FILE="proc.config"

function run()
{
	cfgfile=${CONFIG_FILE}
	cat $cfgfile | while read line
	do
		if [ ${#line} -ge 1 -a "${line:0:1}x" != "#x" ]; then # remove blank and comment line(s)
			i=0;
			proc="";
			cmd="";
			for item in $line; # get process name and start command 
			do
				if [ $i -eq 0 ]; then
					proc=$item;
				else
					cmd="$cmd$item ";
				fi
				((i=$i+1));
			done
			proc_test=`ps auxf | grep $proc | grep -v grep`;
			if [ ${#proc_test} -le 2 ]; then
				echo $proc_test;
				$cmd; 
			fi
		fi
	done
}

run;
