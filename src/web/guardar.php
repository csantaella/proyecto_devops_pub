<?php
    if(isset($_POST['dni'])){
        $conn=new mysqli('mysql','root','admin','prueba');
        $conn->query("
            CREATE TABLE if NOT EXISTS t_formulario(
              dni varchar(127),
              nombre varchar(127),
              candidatos varchar(127),
              PRIMARY KEY(dni)
              );        
        ");
        
        if($conn->query("
            INSERT INTO t_formulario (dni, candidatos, nombre) VALUES (
                '".$conn->real_escape_string($_POST['dni'])."',
                '".$conn->real_escape_string($_POST['candidatos'])."',
                '".$conn->real_escape_string($_POST['nombre'])."'
            );      
        ")) echo 'Datos registrados';
        else echo 'No se han podido registrar tus datos';
    }
?>