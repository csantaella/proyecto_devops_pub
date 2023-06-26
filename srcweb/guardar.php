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
        ")) {
            // Mensaje personalizado si los datos se registran correctamente
            echo '<div style="color: black; font-size: 50px; text-align: center; margin-top: 20px;">¡Datos registrados con éxito!</div>';
            
            // Mostrar los datos introducidos
            echo '<div style="color: black; text-align: left; padding-top: 20px; font-size: 25px; margin-left: 20px;">';
            echo 'DNI: ' . $_POST['dni'] . '<br>';
            echo 'Nombre: ' . $_POST['nombre'] . '<br>';
            echo 'Candidato seleccionado: ' . $_POST['candidatos'] . '<br>';
            echo '</div>';

            echo '<div style="color: black; font-size: 40px; text-align: center; margin-top: 50px;">Gracias por su colaboración</div>';

            echo '<div style="text-align: center; margin-top: 20px;">';
        echo '<a href="index.html" style="text-decoration: none; background-color: #4CAF50; color: white; padding: 10px 20px; font-size: 16px; border-radius: 5px;">Volver al formulario</a>';
        echo '</div>';

        echo '<script>';
        echo 'setTimeout(function() {';
        echo '  window.location.href = "formulario.html";';
        echo '}, 5000);';  // Cambiar 5000 a la cantidad de milisegundos deseados (5 segundos en este ejemplo)
        echo '</script>';
            
        } else {
            // Mensaje personalizado si no se pueden registrar los datos
            echo '<div style="color: black; font-size: 20px; text-align: center; margin-top: 20px;">Ha ocurrido un error al intentar registrar tus datos</div>';
        }
    }
    ?>
   
    
    
    
    
    
    
    