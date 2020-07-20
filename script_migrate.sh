#!/bin/bash
##Modified by Steve Fink stevef-at-ublug.org
##This IMAPSync Batch Script is used when you have different
##usernames on the Source and Destination servers
##(kinda what IMAPSync was intended for)
##the format for the user-list.csv file is

##sourceusername,sourcepassword,destinationusername,destinationpassword 
## Get the info
                while [ -z $infile ]; do
                        echo "What is the path to the input file?"
                        read infile
                done
                while [ -z $host1 ]; do
                        echo "What is the Source Host? (mail1.domain.com)"
                        read host1
                done
                while [ -z $host2 ]; do
                        echo "What is the Destination Host? (mail2.domain.com)"
                        read host2
                done
                #while [ -z $domain ]; do
                #       echo "What is the Domain? (domain.com)"
                #       read domain
                #done
                while [ -z $logfile ]; do
                        echo "Where would you like the log? (synclog.txt)"
                        read logfile
                done

                if [ ! -f $infile ]; then
                        echo "The input file does not exist!"
                        echo ""
                        echo "What is the path to the input file?"
                        read infile
                fi
                INPUTFILE=$infile

                clear
                echo "IMAPSync is about to begin using:"
                echo "Input File $INPUTFILE"
                echo "Source Host $host1"
                echo "Destination Host $host2"
                #echo "Domain $domain"
                echo "Log File $logfile"
                echo ""
                echo "Is this information correct?"
                echo "Press Enter to continue or"
                echo "Hit CTRL+C to start over"
                read wait



## Begin IMAPSync
                date=`date +%X_-_%x`
                echo "IMAPSync Logfile started @ $logfile"
                echo "" >> $logfile
                echo "------------------------------------" >> $logfile
                echo "IMAPSync started..  $date" >> $logfile
                echo "" >> $logfile

        #Get rid of the commas
                tr "," " " <$INPUTFILE | while read u1 u2
                        do
                                user=$u1
                                user2=$u2
                                echo "Syncing User $user to $user2"
                                date=`date +%X_-_%x`
                                echo "Start Syncing User $user to $user2"
                                echo "Starting $u1 $date" >> $logfile
        imapsync --host1 $host1 --user1 $user*master@not-exist.com --password1 jabetto \
                                --host2 $host2 --user2 $user2 --authuser2 admin --password2 jabetto -ssl1 -ssl2 \
                                --nofoldersizes --nofoldersizesatend --skipsize --fast
                                date=`date +%X_-_%x`
                                echo "User $user to $user2 done"
                                echo "Finished $user to $user2 $date" >> $logfile
                                echo "" >> $logfile
                        done

                date=`date +%X_-_%x`
                echo "" >> $logfile
                echo "IMAPSync Finished..  $date" >> $logfile
                echo "------------------------------------" >> $
