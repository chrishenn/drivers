function install {
    foreach ($inf in (gci "$psscriptroot" -r -filter "*inf")) {
        pnputil /add-driver $inf.fullname /install
    }
}
install
