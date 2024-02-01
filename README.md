# COPIAS-VMware #
## Introducción ## 
Para comenzar a realizar esta prueba primero, descargué y probé el funcionamiento de VMware para hacerlo un tanto familiar,
seguidamente estuve buscando funciones únicas que pudieran ayudarme a desarrollar el script.

A continuación el script que he desarrollado
```conf
#!/bin/bash

#Daniel Gutiérrez García

#Variable para la ruta, cambiar por la que se desee 
backup_dir="home/usuario/copias_de_seguridad"

#Array con los nombres de las maquinas que queramos añadir, para lo que habeis pedido Servidor Linux y Servidor Windows
vms=("Servidor Linux" "Servidor Windows")

#Variable para dar la fecha exacta
current_date=$(date +"%Y%m%d_%H%M%S")

#Bucle for para recorrer el array de VMs y realizar las copias de seguridad.
for vm in "${vms[@]}"
do

#Variable para darle nombre al resultado de la copia, añade el directorio que pongamos en backup_dir, le da el valor vm del array y le añade la fecha.
backup_file="$backup_dir/$vm_$current_date.ova"

#Comando para realizar la copia utilizando ovftool
ovftool --acceptAllEulas vi://usuario:contraseña@servidor_VMware/$vm $backup_file

done
```
La explicación más detallada sería la siguiente: 
- `backup_dir`: con esto simplemente creamos una variable y le añadimos la ruta en la que queramos almacenar las copias.
    - `vms=("Servidor Linux" "Servidor Windows")`: crea un array llamado vms con los valores que decidamos añadir, en este caso podría ser el nombre de cualquier máquina que utilicemos.
    - `current_date=$(date +"%Y%m%d_%H%M%S")`: vamos a crear una variable que nos de la fecha exacta en la que se realiza la copia.
        -`%Y`: Representa el año con cuatro dígitos (por ejemplo, 2024).

        -`%m`: Representa el mes con dos dígitos (01 a 12).

        -`%d`: Representa el día del mes con dos dígitos (01 a 31).

        -`%H`: Representa la hora en formato de 24 horas con dos dígitos (00 a 23).

        -`%M`: Representa los minutos con dos dígitos (00 a 59).

        -`%S`: Representa los segundos con dos dígitos (00 a 59).
    
    - `for vm in "${vms[@]}" do` : Realizamos un bucle for que recorre el array declarado anteriormente (vms)
    - `backup_file="$backup_dir/$vm_$current_date.ova"`: hacemos una variable para darle el nombre al archivo, como ya he explicado anteriormente `backup_dir` pone la ruta, `$vm` es el valor que hay en el array `vms` y `$current_data` inserta la fecha.
 
    - `ovftool --acceptAllEulas vi://usuario:contraseña@servidor_VMware/$vm $backup_file`: este comando fue uno de los que descubrí al buscar información sobre VMware, `ovftool` es una herramienta normalmente recomendada para realizar las copias en formato .ova o .ovf ya que te proporciona la posibilidad de importar y exportar máquinas. El desglose del comando sería tal que así:

      -`--acceptAllEulas`: este comando indica a ovftool que acepte automáticamente las EULAs sin que tengamos que hacerlo manualmente. Esto viene bien si queremos automatizar el script como lo es en nuestro caso.
      
      -`vi//`: indica que accedemos a una máquina en un entorno virtual VMware.

      -`usuario:contraseña`: Debes reemplazar con las credenciales adecuadas para autenticarte en el servidor VMware.

      -`servidor_vmware`: Es la dirección o nombre del servidor VMware al que queremos conectarnos.

## Otras indicaciones ##
Con el script realizado tenemos que hacer unos pasos más. El primero será darle permisos de ejecución, para ello utilizamos el comando `crontab -e` y añadimos la siguiente línea: `0 0 * * 2 /[ruta del script]/script_cp_seguridad.sh`.

En la línea que añadimos en crontab el primer 0 indica el minuto, el segundo 0 la hora, el primer asterisco que lo realiza cualquier día, el segundo asterisco todos los meses y con el último 2 indicamos el día de la semana, que se corresponde con el martes. Al indicar con el 2 que se realiza los martes, el primer asterisco realizará la copia todos los martes de todos los meses.

Es importante saber que para utilizar el comando ovftool necesitamos instalar su herramienta correspondiente, como la máquina es ubuntu sería tal que así:
```conf
tar -zxvf VMware-ovftool-4.4.0-16360108-lin.x86_64.bundle.tar.gz
cd vmware-ovftool-distrib
sudo ./vmware-ovftool.bundle
```
Primero descomprimimos el archivo tar.gz, seguido hacemos cd para ir al directorio que se crea al descomprimir el archivo y ejecutamos el script de instalación que contiene el directorio.
Si quisieramos hacerlo en windows solo tendríamos que descargar el archivo .exe y ejecutarlo.

## Conexion entre la máquina y el servidor VMWare ##
Buscando y probando la manera más fácil es instalar en la máquina cliente la función ssh, para acceder al servidor podríamos hacerlo de la siguiente manera: `ssh [usuario]@[dirección-ip-servidor]`.
Al introducir el comando si funciona correctamente, nos deberá pedir la contraseña correspondiente del usuario con el que queramos acceder.



      


    




