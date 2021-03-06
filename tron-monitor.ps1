# Tron Monitor v0.4
# https://github.com/dbriggsie/tron-monitor/
#
# All the lines starting with # Tag are a comment, please read them carefully to configure settings correctly.
# This program will run in an infinite loop, which means you need to stop this script if you don't want to let it run.

#Please Change the Producerkey to your own Witness Address.
$ProducerKey = "TAbzgkG8p3yF5aywKVgq9AaAu6hvF2JrVC"

# Configure this Minute value, so that script can run on this interval, 5 value denotes that script will wait for 5 minute 
# to re-check, Change according to the requirement can be any decimal value 1,2,3,4,5 etc...
$CheckAfterEveryMin = 1

#Configure the from email id
$EmailFrom = "user@domain.net"

#Configure email id to whom you want to send email
$EmailTo = "user@domain.net"

#Configure the subject line
$EmailSubject = "[Alert] Witness Node has Stopped Producing Blocks"

#Configure SMTP server either name or IP address 
$SMTPServer = "smtphost.domain.net"

#Default SMTP port is 25 but incase SMTP is running on any other port, configure this $smtpport value
$SMTPPort = 25

#Configure the user name who is authorized to send an email
$SMTPAuthUsername = "username"

#Configure password of the user
$SMTPAuthPassword = "password"

#Configure the Settings to use SSL
$UseSSL = $true

#Configure the body text of the email
$emailbody = "[Alert] Witness Node has Stopped Producing Blocks"


$SMTPAuthPassword = $SMTPAuthPassword | Convertto-SecureString -AsPlainText -Force
$credentials = New-Object System.Management.Automation.Pscredential ($SMTPAuthUsername, $SMTPAuthPassword)


#Functions & Variables
$global:ProducerNumber = 0
$global:latestNumber  = 0

function send_email {

if ($UseSSL)
{
Send-MailMessage -To $EmailTo -From $EmailFrom  -SMTPServer $SMTPServer -UseSsl -Port $SMTPPort -Credential $credentials -Subject $EmailSubject -Body $emailbody
}
else
{
Send-MailMessage -To $EmailTo -From $EmailFrom  -SMTPServer $SMTPServer -Port $SMTPPort -Credential $credentials -Subject $EmailSubject -Body $emailbody

}

}


function Get-blockdifference
{

$url = "https://api.tronscan.org/api/block?sort=-number&limit=1&count=true&producer=$ProducerKey"
$txt = Invoke-RestMethod $url 
$global:latestNumber  = $txt.data[0].number

if ($global:latestNumber -eq $global:ProducerNumber)
{
$blockdifference = $true
}
else
{
$blockdifference = $false
}
return $blockdifference
}


while(1)
{
$blockdifference = get-blockdifference

$waitforSeconds = 60 * $CheckAfterEveryMin
$Time = Get-Date -DisplayHint Time
if ($blockdifference)
{
Write-Host "Tron Monitor is Running - Witness Node has Stopped Producing Blocks" -BackgroundColor Red -ForegroundColor Black
Write-Host "Current Block: $global:latestNumber" -BackgroundColor Blue -ForegroundColor White
Write-Host "Last Block: $global:ProducerNumber" -BackgroundColor Blue -ForegroundColor White
Write-Host "Time $time" -BackgroundColor Blue -ForegroundColor White
Write-Host " "
send_email
} 
else
{
Write-Host "Tron Monitor is Running - Witness Node is Operating Normally" -BackgroundColor Green -ForegroundColor Black
Write-Host "Current Block: $global:latestNumber" -BackgroundColor Blue -ForegroundColor White
Write-Host "Last Block: $global:ProducerNumber" -BackgroundColor Blue -ForegroundColor White
Write-Host "Time $time" -BackgroundColor Blue -ForegroundColor White
Write-Host " "
}
$global:ProducerNumber = $global:latestNumber
Start-Sleep -Seconds $waitforSeconds
}