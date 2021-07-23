# Made by Jonathan Rondón

# Loop to re-run the script
do {
	Clear-Host
	Write-Output @"
PC NAME FINDER BY USERNAME (SCCM)
Version: 0.0.3

Author: Jonathan Rondon (Rons)
Twitter: @JonathanERC
GitHub: https://github.com/JonathanERC/PCNameByUser-SCCM

"@
	# Defining config file route in running script location
	$configPath = (split-path -parent $MyInvocation.MyCommand.Definition)+"\PCNameByUser.config"

	# If the config file doesn't exist, create one
	if (!(Test-Path $configPath))
	{
		Write-Output "Config file not found. Creating a new one..."

		$argPrefix = Read-Host -Prompt "Write Domain name"
		$argNameSpace = Read-Host -Prompt "Write SCCM Namespace (ex: root\sms\site_contoso)"
		$argServerName = Read-Host -Prompt "Write SCCM Servername"

		Write-Output @"
<root>
	<prefix>$argPrefix</prefix>
	<nameSpace>$argNameSpace</nameSpace>
	<serverName>$argServerName</serverName>
</root>
"@ >> $configPath
	}

	# Read the config file
	$config = ([xml](Get-Content $configPath)).root
	
	# If not username is set in argument then ask for the username
	if ($null -eq $args[0]) {
		$paramUser = Read-Host -Prompt "Write domain Username"
		$user = $config.prefix+"_"+$paramUser
	} else {
		$user = $config.prefix+"_"+$args[0]
	}

	# Query to find the devices name
	$query = "SELECT * 
	FROM SMS_G_SYSTEM_SYSTEM_CONSOLE_USER 
	INNER JOIN SMS_R_SYSTEM 
	ON SMS_R_SYSTEM.RESOURCEID = SMS_G_SYSTEM_SYSTEM_CONSOLE_USER.RESOURCEID 
	WHERE SMS_G_SYSTEM_SYSTEM_CONSOLE_USER.SYSTEMCONSOLEUSER 
	LIKE '$user'"

	# Funtion to send the query and filter the devices name
	Get-WmiObject -Query $query -Namespace $config.nameSpace -ComputerName $config.serverName | ForEach-Object {
		$PCName = $_.SMS_R_System.ResourceNames[0]
		$result = Select-Object  -InputObject "" PCName
		$result.PCName= $PCName
		Start-Sleep 2
		Write-Output $result <#| Select-Object @{Name="PC Name of "+$user.replace("$config.prefix+"_"",""); Expression={$_.PCName}} #>
	}
	Start-Sleep 1
	Write-Output ""

	# Set argument to null
	if ($null -ne $args[0]) {
		$args[0] = $null
	}

	Write-Host -NoNewline "Press 'r' to run again..."
	# Read if the key send is a 'r' to run the script again
	$response = $Host.UI.RawUI.ReadKey() 
}
# If the sent letter is 'r' run the script again
while ($response.Character -eq 'r')