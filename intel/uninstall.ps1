function uninstall {
    foreach ($inf in (gci "$psscriptroot\drvr" -r -Filter "*inf")) {
        pnputil /delete-driver $inf.fullname /uninstall
    }
}
uninstall