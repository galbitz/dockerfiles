FROM galbitz/sql2008r2
ENV sa_password=P@ssword1
ENV ACCEPT_EULA=Y
ADD tenant_main.bak /
ADD fart.exe /
RUN Invoke-Sqlcmd \"RESTORE DATABASE [tenant_main] FROM  DISK = N'C:\\tenant_main.bak' WITH  FILE = 1,  MOVE N'EIP_Data' TO N'C:\\SQL2008\\SQLData\\tenant_main.mdf',  MOVE N'EIP_Log' TO N'C:\\SQL2008\\SQLData\\tenant_main_log.ldf',  NOUNLOAD,  STATS = 5\"
COPY start.ps1 /
RUN mkdir /data
ENTRYPOINT .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose  
