function uninstall () {
    foreach ($dir in get-childitem "$psscriptroot\drvr" -directory) {
        $setup = get-childitem $dir -filter "uninstall.ps1"
        if (-not $setup) {
            write-host -f r "error: couldn't find instupd.exe for $dir"
            continue
        }
        & "$setup"
    }
}
uninstall
