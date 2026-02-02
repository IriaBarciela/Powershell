$carpetas = Get-ADOrganizationalUnit `
    -SearchBase "OU=Alumnado,OU=Usuarios,OU=Sede-Vigo,DC=xilgaro-dm,DC=intranet" `
    -Filter * -SearchScope OneLevel



$carpetas.name | ForEach-Object {

    $carpeta = $_

    Write-Host "Creando carpeta: $carpeta"



    New-Item -Path Z:\DatosXilgaro\Usuarios\Alumnado\$carpeta  -ItemType Directory

    New-Item -Path Z:\DatosXilgaro\Recursos\Alumnado\$carpeta  -ItemType Directory



}

foreach ($carpeta in $carpetas.name ) {


    Write-Host "Creando asignaturas para: $carpeta"


    $modulos = Get-Content -Path "Z:\Asignaturas\$carpeta.txt" -Encoding Ascii


    foreach ($modulo in $modulos) {
        

        New-Item -Path "Z:\DatosXilgaro\Usuarios\Alumnado\$carpeta\$modulo" -ItemType Directory
        New-Item -Path "Z:\DatosXilgaro\Recursos\Alumnado\$carpeta\$modulo" -ItemType Directory
    
    }
}
