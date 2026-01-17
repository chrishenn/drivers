# XPS 9320 Drivers

This is the "realtek audio driver" package for the XPS 9320 from Dell. 
Wouldn't you know it, the 9320 audio works just fine without any realtek nor waves audio software.
I deleted all the realtek services and waves files, and the installer will happily install Intel drivers, which work 
just fine.

install
```bash
# download driver exe from dell support 
# extract driver installer
7z x pkg.exe

# delete any files with these stems in the name
- waves
- maxx
- realtekservice
- rtkaudservice

$p = start-process -passthru dellmup.exe -a '/s'
$p.exitcode
3010

# reboot not required for audio to work, but according to ms:
# ERROR_SUCCESS_REBOOT_REQUIRED
# A restart is required to complete the install. This message indicates success. 
```

uninstall (manual only)
- go to device manager
- right click -> uninstall and "attempt to remote" all under "audio" and "sound"
- reboot