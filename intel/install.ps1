function install {
    foreach ($inf in (gci "$psscriptroot\drvr" -r -Filter "*inf")) {
        pnputil /add-driver $inf.fullname /install
    }
}
install
