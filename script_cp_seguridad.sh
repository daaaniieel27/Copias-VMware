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