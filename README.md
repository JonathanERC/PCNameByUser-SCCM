# PCNameByUser-SCCM

### Table of Contents
+ [Description](#description)
+ [Usage](#usage)  
  + [Inline](#inline)
  + [Run](#run)
+ [Changelog](#changelog)

## Description
#### Powershell script to get all user devices registered in SCCM.

PCNameByUser-SCCM will send a query to SCCM and return all user devices.

Many times, **Help Desk** or **IT Support department** doesn't have a way to get a user's PC name without having to ask the user, which means if the user doesn't know the PC name, the technician hase to give the user instructions on how to get it. In summary, time wasted.

If the company you work for has SCCM implemented and deployed, then this script could help you get the PC name with usernames without having to ask the user.

## Usage

In order to run the script, a configuration file in the current script running location needs to load. If the configuration file is not found, the script will create a new one and will ask the user all the relevant information. See [this](PCNameByUser.config) file as a **reference**.

The script asks for the following requirement if the configuration file is missing:
- Domain name (Not like contoso.local but contoso)
- SCCM Namespace (like root\sms\site_contoso)
- SCCM Servername (like W12SCCM01)

#### There are two ways to run this script:

#### Inline

The script waits for one username as unique argument.

**Example:** 
> `./PCNameByUser.ps1 Rons`
> 
> PC NAME FINDER BY USERNAME (SCCM)
> Version: 0.0.3
> 
> Author: Jonathan Rondon (Rons)
> Twitter: @JonathanERC
> GitHub: https://github.com/JonathanERC/PCNameByUser-SCCM
> 
> PCName
> 
> W10JRLAB01.contoso.local
> 
> W10JRLAB02.contoso.local

#### Run

If you run the script without argument, the script will ask for a username and in the end, it will ask you to press '**r**' to run again.

**Example:** 
> `./PCNameByUser.ps1`
> 
> PC NAME FINDER BY USERNAME (SCCM)
> Version: 0.0.3
> 
> Author: Jonathan Rondon (Rons)
> Twitter: @JonathanERC
> GitHub: https://github.com/JonathanERC/PCNameByUser-SCCM
> 
> Write domain Username: Rons
> 
> PCName
> 
> W10JRLAB01.contoso.local
> 
> W10JRLAB02.contoso.local
> 
> Press 'r' to run again...


## Changelog

#### Version 0.0.3
- [Added] - Inline execution.
- [Added] - Config file.
- [Changed] - Logic improvements.

#### Version 0.0.2
- [Added] - Loop to run the script again at the end.
- [Changed] - Logic improvements.
- [Fixed] - The script closed after running, without showing result.

#### Version 0.0.1
- First release.
