# Notifier

Sends Notification to your Slack Channel. Can use as Shell Command or add as a App under your Automator Work Flow

P.S. I needed a script to send message to my personal slack channel everytime someone logged into my mac. So added it to login items. And to know when my remote tasks are completed if i am not available on my system.

So i use :

Note : Change your Slack Hooks URL in Environment.swift , and rebuild Swift files before copying Shell to usr/local/bin

```sh
 $ git clone heavyRepo && NotifyMe "Git Clone Completed"
```

## Build : 
```sh
//Change to your Slack Hook Point in Environment.swift before building
$ swiftc main.swift Notifier.swift Environment.swift -o NotifyMe
```

## Move to Home Shell Path : 
```sh
$ cp NotifyMe /usr/local/bin
// or else run in Proj Directory
$ ./NotifyMe
```

## Usage : 
```sh
$ NotifiyMe
// or
$ NotifyMe arg1
// where arg1 is your Message
// or

$ git clone repo && NotifyMe "Git Clone Done"
$ zip docs.zip -f -r /home/documents && NotifyMe "Files Ziped"
$ ./backupEC2.sh && NotifyMe "Mongo Backup Complete"
```
