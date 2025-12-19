function install () {
    write-host ''
    write-host ''

    foreach ($dir in get-childitem "$psscriptroot\drvr" -directory) {
        $setup = get-childitem $dir -filter "instupd.exe"
        if (-not $setup) {
            write-host -f r "error: couldn't find instupd.exe for $dir"
            continue
        }
        write-host -f c "installing: $setup"
        start-process -wait $setup.fullname -a '-s'
    }
}
install
