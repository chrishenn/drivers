function install {
    write-host ''
    write-host ''

    foreach ($exe in gci "$psscriptroot\drvr" -file -filter *.exe) {
        write-host -f c "installing: $exe"
        start-process -wait -nonewwindow $exe.fullname -a '/s'
    }
    foreach ($dir in gci "$psscriptroot\drvr" -directory) {
        if ($setup = gci $dir -file -filter 'install.ps1') {
            write-host -f c "installing: $setup"
            & $setup.fullname
        }
    }
}
install
