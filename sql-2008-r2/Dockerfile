FROM microsoft/dotnet-framework:3.5

# Download Links:
#ENV sql_express_download_url "https://go.microsoft.com/fwlink/?linkid=829176"

ENV chocolateyUseWindowsCompression false
RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'));

RUN choco install 7zip -y

ENV sql_express_download_url https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRADV_x64_ENU.exe

ENV sa_password _
ENV attach_dbs "[]"
ENV ACCEPT_EULA _

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# make install files accessible
COPY start.ps1 /
WORKDIR /

#7z x .\sqlexpress.exe -osetup
#/FILESTREAMSHARENAME='MSSQLSERVER' /FEATURES=SQLEngine,FullText /FILESTREAMLEVEL=1

RUN Invoke-WebRequest -Uri $env:sql_express_download_url -OutFile sqlexpress.exe ; \
        7z x .\sqlexpress.exe -osetup ; \
        .\setup\setup.exe /q /ACTION=Install /SKIPRULES=PerfMonCounterNotCorruptedCheck /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine,FullText /SQLSVCACCOUNT='NT AUTHORITY\System' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS /SQLTEMPDBDIR='C:\SQL2008\TempDB\' /SQLUSERDBDIR='C:\SQL2008\SQLData\' /SQLUSERDBLOGDIR='C:\SQL2008\SQLLog\' ; \
        Remove-Item -Recurse -Force sqlexpress.exe, setup

RUN stop-service MSSQL`$SQLEXPRESS ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql10_50.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql10_50.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; \
        set-itemproperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql10_50.SQLEXPRESS\mssqlserver\' -name LoginMode -value 2 ;

CMD .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose  