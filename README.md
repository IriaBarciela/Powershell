# AD Administration | Infrastructure Automation 

Este repositorio contiene una colección de scripts de PowerShell diseñados para automatizar el ciclo de vida de usuarios y la gestión de cuotas de archivos en un entorno de Active Directory.

## Contenido del Repositorio

### 1. Gestión de Identidades
* **New-ADTeacherUser.ps1**: Crea usuarios de profesorado con configuración de seguridad completa.
* **Move-StudentToGroup.ps1**: Automatiza el cambio de grupo y OU de alumnos.
* **Migrate-UsersByCSV.ps1**: Procesa un CSV para mover usuarios entre distintas delegaciones de Educación.

### 2. Gestión de Infraestructura
* **New-DepartmentStructure.ps1**: Crea la jerarquía de OUs y grupos de seguridad necesarios.
* **Initialize-StudentStorage.ps1**: Escanea el AD y genera automáticamente la estructura de carpetas en el servidor de archivos (Z:).

## Requisitos
- Módulo `ActiveDirectory` de PowerShell.
- Conectividad con el controlador de dominio.
- Estructura de archivos en unidad `Z:` para los scripts de almacenamiento.
