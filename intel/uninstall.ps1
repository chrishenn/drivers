$sdir = $psscriptroot

foreach ($inf in (gci "$sdir\drvr" -r -Filter "*inf")) {
    pnputil /delete-driver $inf.fullname /uninstall
}
