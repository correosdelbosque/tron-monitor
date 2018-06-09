<h1 align="center">
  <img src="https://github.com/dbriggsie/tron-monitor/blob/master/tron-monitor.png">
  <br/>
  Tron Monitor
</h1>
Tron Monitor is a monitoring script built in Powershell for checking that your SR Node is producing blocks. The script will send an email to alert you if you havent produced blocks for over 2 minutes. This will be most useful for Tron Super Representatives & Tron Super Representative Candidates, although anyone running a Tron Node can use it to prepare themselves for being voted in to top 27 as SR.



  
<h3>Sponsors</h3>
No sponsors yet.. Will you be the first? Sponsors get access to (pre-releases) not yet released features.
<br/>

# How to use
Firstly, you will need to install powershell on the machine which is or will run your **java-tron** witness node.
   ## Installing Powershell on Ubuntu 16.04
      # Import the public repository GPG keys
        curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

      # Register the Microsoft Ubuntu repository
        curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list | sudo tee /etc/apt/sources.list.d/microsoft.list

      # Update apt-get
        sudo apt-get update

      # Install PowerShell
        sudo apt-get install -y powershell

      # Start PowerShell
        powershell
  
## Forking the tron-monitor code using git
      # git clone https://github.com/dbriggsie/tron-monitor.git
