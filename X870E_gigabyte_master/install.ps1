function install () {
    write-host ''
    write-host ''

    foreach ($dir in get-childitem "$psscriptroot\drvr" -directory) {
        if ($setup = get-childitem $dir -filter "instupd.exe") {
            write-host -f c "installing: $setup"
            start-process -wait $setup.fullname -a '-s'
            continue
        }
        if ($setup = get-childitem $dir -filter "install.ps1") {
            write-host -f c "installing: $setup"
            & $setup.fullname
            continue
        }
        write-host -f r "error: couldn't find instupd.exe nor install.ps1 for $dir"
    }
}
install
