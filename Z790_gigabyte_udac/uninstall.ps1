function uninstall () {
    write-host ''
    write-host ''

    foreach ($dir in get-childitem "$psscriptroot\drvr" -directory) {
        $setup = get-childitem $dir -filter "uninstall.ps1"
        if (-not $setup) {
            write-host -f r "error: couldn't find uninstall.ps1 for $dir"
            continue
        }
        write-host -f c "uninstalling: $setup"
        & "$setup"
    }
}
uninstall
