function interactive {
    $noni = [Environment]::GetCommandLineArgs() | Where-Object{ $_ -like '-NonI*' }
    return ([Environment]::UserInteractive -and -not $noni)
}

function find_ustr ($name) {
    $keys = @(
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )
    if ($chld = Get-childitem $keys | get-itemproperty | Where-Object {$_.DisplayName -match "$name"}) {
        return $chld.uninstallstring
    }
    return $null
}

function uninstall ($name) {
    if (-not (interactive)) {
        write-host -f r "error: can't uninstall without an interactive shell ($dir)"
        return
    }
    if (-not ($ustr = find_ustr $name)) {
        write-host -f r "error: couldn't find uninstall string for $dir"
        return
    }
    if (-not $ustr.contains('setup.exe')) {
        write-host -f r "error: couldn't find setup.exe in uninstall string for $dir"
        return
    }

    $ustrs = $ustr.replace('"', '').split("\setup.exe")
    $exe = $ustrs[0]
    start-process -wait "$exe\setup.exe" -a '/remove /silent /v"/qn" /hide_progress /hide_splash /runfromtemp /removeonly'
}
uninstall "realtek audio driver"