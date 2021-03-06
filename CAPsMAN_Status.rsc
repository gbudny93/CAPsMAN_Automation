# RouterOS Function 
# Copyright (c) Grzegorz Budny 
# Version 1.0 
# Last update: 2/8/2020
# Generates e-mail CAPsMAN status 

:global CAPsMANStatus do={

    :local intCount         [/caps-man remote-cap print count-only];
    :local remoteCapCount   [/caps-man remote-cap print count-only];
    :local regTableCount    [/caps-man registration-table print count-only];
    :local inactiveIntCount [/caps-man interface print count-only where inactive];
    :local masterIntCount   [/caps-man interface print count-only where master];
    :local disabledIntCount [/caps-man interface print count-only where disabled];
    :local boundIntCount    [/caps-man interface print count-only where bound];
    :local channelCount     [/caps-man channel print count-only];
    :local aclCount         [/caps-man access-list print count-only];
    :local radiusCount      [/radius print count-only];
    #:local dnsServers       [/ip dns get value-name=servers];

    :local systemName       [/system identity get value-name=name];
    :local uptime           [/system resource get uptime];
    :local FreeMemory       [/system resource get free-memory];
    :local TotalMemory      [/system resource get total-memory];
    :local cpu              [/system resource get cpu];
    :local cpuCount         [/system resource get cpu-count];
    :local cpuFrequency     [/system resource get cpu-frequency];
    :local cpuLoad          [/system resource get cpu-load];
    :local freeHdd          [/system resource get free-hdd-space];
    :local totalHdd         [/system resource get total-hdd-space];
    :local architectureName [/system resource get architecture-name];  
    :local license          [/system license get level];
    :local boardName        [/system resource get board-name];
    :local version          [/system resource get version];


    /tool e-mail send server=$smtpServer port=$smtpPort from=($systemName.$domain) \ 
        to=$recipient subject=($systemName." status")       \
        body=($systemName." system status: \n\n"            \ 
             ."Uptime: ".$uptime."\n"                       \
             ."Free Memory: ".$FreeMemory." B \n"           \
             ."Total Memory: ".$TotalMemory." B \n"         \
             ."CPU ".$cpu."\n"                              \
             ."CPU Count: ".$cpuCount."\n"                  \
             ."CPU Frequency: ".$cpuFrequency."MHz\n"       \
             ."CPU Load: ".$cpuLoad." % \n"                 \
             ."Free HDD Space: ".$freeHdd." B \n"           \
             ."Total HDD Space:".$totalHdd." B \n"          \
             ."Architecture: ".$achritecture." \n"          \
             ."License Level: ".$license." \n"              \
             ."Board Name: ".$boardName." \n"               \
             ."Version: ".$version."\n\n\n"                 \
             ."CAP Interfaces: ".$intCount."\n"             \
             ."CAPs Registered: ".$remoteCapCount."\n"      \
             ."Hosts Registered: ".$regTableCount."\n"      \  
             ."Inactive Interfaces: ".$inactiveIntCount."\n"\
             ."Master Interfaces: ".$masterIntCount."\n"    \
             ."Disabled Interfaces: ".$disabledIntCount."\n"\
             ."Bouneded Interfaces: ".$boundIntCount."\n"   \
             ."Channels defined: ".$channelCount."\n"       \
             ."ACLs defined: ".$aclCount."\n"               \
             ."Radius Defined: ".$radiusCount);

}

$CAPsMANStatus smtpServer=smtpServer smtpPort=smtpPort domain=domain recipient=recipient@example.com;