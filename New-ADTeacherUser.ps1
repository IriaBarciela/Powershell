param(

[Parameter(Mandatory)]$login,
[Parameter(Mandatory)]$password,
[Parameter(Mandatory)]$nome,
[Parameter(Mandatory)]$apelidos, 
[Parameter(Mandatory)]$departamento, 
[Parameter(Mandatory)]$email

)


if ($login -eq "" -or $password -eq "" -or $nome -eq "" -or $apelidos -eq "" -or $departamento -eq "" -or $email -eq "") {

    Write-Host "Los campos no pueden estar vacíos"

} else {

    if (Get-ADUser -Filter "samaccountName -eq '$login'"){

        Write-Host "El usuario ya existe"

     } else {

     $groupName = "Profes-$departamento"

        if (Get-ADGroup -Filter "Name -eq '$groupName'") {
        

            New-ADUser `
            -DisplayName:"$nome $apelidos" `
            -EmailAddress:"$email" `
            -GivenName:"$nome" `
            -Name:"$nome $apelidos" `
            -Surname "$apelidos" `
            -Path:"OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
            -SamAccountName:"$login" `
            -Server:"E1-XDC-01.xilgaro-dm.intranet" `
            -Type:"user" `
            -UserPrincipalName:"$login@xilgaro-dm.intranet" `
            -Description: "Profesorado del departemanto de $departamento"
        
            $ContraseñaCifrada = ConvertTo-SecureString -string "$password" -AsPlainText -Force

            Set-ADAccountPassword `
            -Identity:"CN=$nome $apelidos,OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
            -NewPassword: $ContraseñaCifrada `
            -Reset:$true `
            -Server:"E1-XDC-01.xilgaro-dm.intranet"

            Enable-ADAccount `
            -Identity:"CN=$nome $apelidos,OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
            -Server:"E1-XDC-01.xilgaro-dm.intranet"

            Set-ADAccountControl `
            -AccountNotDelegated:$false `
            -AllowReversiblePasswordEncryption:$false `
            -CannotChangePassword:$false -DoesNotRequirePreAuth:$false `
            -Identity:"CN=$nome $apelidos,OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
            -PasswordNeverExpires:$false `
            -Server:"E1-XDC-01.xilgaro-dm.intranet" `
            -UseDESKeyOnly:$false

            Set-ADUser `
            -ChangePasswordAtLogon:$true `
            -Identity:"CN=$nome $apelidos,OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
            -Server:"E1-XDC-01.xilgaro-dm.intranet" `
            -SmartcardLogonRequired:$false

            Add-ADPrincipalGroupMembership `
            -Identity:"CN=$nome $apelidos,OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
            -MemberOf:"CN=Profes-$departamento,OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
            -Server:"E1-XDC-01.xilgaro-dm.intranet"

            Write-Host "Creado con exito"

        
        }else {
        
            Write-Host "El grupo no existe"

        }


     }
}
