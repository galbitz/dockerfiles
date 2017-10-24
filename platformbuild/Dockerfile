FROM microsoft/dotnet-framework:3.5

#Need both 3.5 and 4.6.2 framework
RUN set COMPLUS_NGenProtectedProcess_FeatureEnabled=0 & \
    \Windows\Microsoft.NET\Framework64\v4.0.30319\ngen update & \
    \Windows\Microsoft.NET\Framework\v4.0.30319\ngen update

#install Chocolatey
ENV chocolateyUseWindowsCompression false
RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'));

#install git
RUN choco install git -y

#install Nunit 2.6.4
RUN choco install nunit --version 2.6.4 -y

#install Ruby 1.9.3
RUN choco install ruby1.9 -y

#install Sass compiler
RUN gem install ffi -v 1.9.8 --no-ri --no-rdoc
RUN gem install compass -v 1.0.3 --no-ri --no-rdoc
RUN gem install sass-css-importer --pre --no-ri --no-rdoc

#install .Net SDK (linking tools)
RUN choco install windows-sdk-8.1 -y

#install Microsoft Build Tools 2013
RUN choco install microsoft-build-tools --version 12.0.21005.20140416 -y

#install MVC 2.0
RUN choco install aspnetmvc2 -y

#install nuget
RUN choco install nuget.commandline -y

#set msbuild path
RUN setx /m PATH "%PATH%;C:\Windows\Microsoft.NET\Framework\v4.0.30319"

#set sdk tools folder 
RUN setx /m TargetFrameworkSDKToolsDirectory "c:\Program Files (x86)\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools"

#install Windows 10 SDK (aspnet merge tool)
RUN choco install windows-sdk-10.0 -y

#install Webdeploy 3.5
ADD https://download.microsoft.com/download/D/4/4/D446D154-2232-49A1-9D64-F5A9429913A4/WebDeploy_amd64_en-US.msi WebDeploy_amd64_en-US.msi
RUN msiexec /i WebDeploy_amd64_en-US.msi /qn

#create folder for packages
RUN mkdir c:\builds\deployments
