param (
    [parameter(mandatory=$true)]$departamento
)

if ($departamento -eq "") {

    Write-Host "El departamento no puede estar vacío"

} else {
    $OU_generico = "OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet"

    $OU_completa = "OU=$departamento,$OU_generico"

    # Cuidado esta linea hay que poner un distinguished name

    $OU = "OU=$departamento,OU=Profesorado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet"

    if (Get-ADOrganizationalUnit -Filter "distinguishedName -eq '$OU'") {

        Write-Host "El departamento ya existe"

    } else {

        # Crear OU

        New-ADOrganizationalUnit -Name $departamento -Path $OU_generico


        Write-Host "Se creó la OU"
    }

    if (Get-ADGroup -Filter "Name -eq 'Profes_$departamento'") {

        Write-Host "El grupo Profes_$departamento ya existe"

    } else {

        # Crear grupo
        New-ADGroup -Name "Profes_$departamento" -GroupScope Global -Path $OU_completa -Description "Grupo de profesorado do departamento $departamento"
        
        Write-Host "Se creó el grupo"
    }

    Write-Host "Compeltado con exito"

}
