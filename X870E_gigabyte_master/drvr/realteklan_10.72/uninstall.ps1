function uninstall {
    foreach ($inf in (gci "$psscriptroot" -r -Filter "*inf")) {
        pnputil /delete-driver $inf.fullname /uninstall
    }
}
uninstall