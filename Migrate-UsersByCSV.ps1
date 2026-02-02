$csv = Import-Csv -Delimiter ":" -Path Z:\Vigo-Ourense.csv -Encoding UTF8

foreach ($usuario in $csv){

    if ($usuario.Grupo -eq "Educación"){

        $nombreusuario= Get-ADUser -Identity $usuario.LoginDefinitivo |select name
        
        $usuarioedu = ("CN=" + $nombreusuario.name + ",OU=Educación,OU=Consellerías,DC=xunta,DC=local")

        Move-ADObject -Identity $usuarioedu `
        -TargetPath ("OU=" + $usuario.Destino + ",OU=Educación,OU=Consellerías,DC=xunta,DC=local")

        Write-Host ("Moviendo a " + $usuario.LoginDefinitivo +  " a " + $usuario.Destino)
    
    }else{

        Write-Host "No es un usuario de educación"

    }

}
