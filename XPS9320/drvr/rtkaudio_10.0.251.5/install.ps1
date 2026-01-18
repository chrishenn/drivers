function svc_rm (
    [Parameter(Mandatory = $true)][string] $name
) {
    stop-service -ea 0 -force $name
    set-service -ea 0 $name -startuptype 'disabled'
    if ($PSVersionTable.PSVersion.Major -gt 5) {
        remove-service -ea 0 $name
    } else {
        [void](sc.exe delete $name)
    }
}

function bloat_waves {
    svc_rm WavesSysSvc
    svc_rm WavesAudioService

    rm -r -force -ea 0 "C:\Program Files\Waves"
    rm -r -force -ea 0 "C:\Program Files (x86)\Waves"
    rm -r -force -ea 0 "C:\ProgramData\Waves Audio"
    rm -r -force -ea 0 "C:\ProgramData\Waves"

    $dstore = 'C:\windows\system32\driverstore\filerepository'
    $dirs = gci $dstore -directory | ? {$_.name -match 'waves'}
    foreach ($dir in $dirs) {
        pnputil /delete-driver $dir.fullname /uninstall
    }
}

function install {
    $setup = gci $psscriptroot -file -filter 'dellmup.exe'
    write-host -f c "installing: $($setup.fullname)"
    start-process -wait -nonewwindow $setup.fullname -a '/s /v "/FORCE=true /FORCERESTART=false"'

    write-host -f c 'removing waves audio'
    bloat_waves
}

install