param (
    [parameter(mandatory=$true)]$login,
    [parameter(mandatory=$true)]$grupo
)


if ($login -eq "" -or $grupo -eq ""){
        
    Write-Host "El login o el grupo no pueden estar vacíos"
    Write-Host "login: Debe ser el samacount del usuario"
    Write-Host "grupo: Es el grupo al que queremos mover el usuario"

}else {

    if (Get-ADUser -Filter "samAccountName -like '$login'") {
        
        if (Get-ADGroup -Filter "SamAccountName -like 'Alumnos-$grupo'") {

            $usuario = Get-ADUser $login


            # Matricula

            $OU = "OU=$grupo,OU=Alumnado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet"

            Move-ADObject -Identity $usuario -TargetPath $OU -Confirm:$false


            #Eliminar del anterior grupo

            $OLD_Group = Get-ADPrincipalGroupMembership -Identity $login |select name |where name -like 'Alumnos*'

            Remove-ADGroupMember $OLD_Group[0].name -Members $login -Confirm:$false


            #Añadir al nuevo grupo

            Add-ADGroupMember -identity "Alumnos-$grupo" -members $usuario 


            # Poner descripcion

            Set-aduser $login -description "Alumno de $grupo"

        } else {

        Write-Host "No se encontro el grupo $grupo"
        
        }


    } else  {

            Write-Host "No se encontro el usuario $login"

      }
}
